# fzf `**` trigger completion for `git checkout` / `git switch`

## Problem

fzf ships fuzzy `**`-trigger completion for a predefined set of commands
(`vim **<TAB>`, `cd **<TAB>`, `kill **<TAB>`, `ssh **<TAB>`, etc.), wired up
inside its own `completion.bash` (installed by Nix, shared via `fzf-share`).
`git checkout`/`git switch` are not among them — normal (non-fuzzy) branch/tag
completion for them comes from `bash-completion`'s own git script.

Separately, `git forgit` (`fzf/git/git-forgit`) already has a polished
interactive branch picker (`_forgit_checkout_branch`, with preview and
smart tracking-branch checkout), but it's a distinct subcommand
(`git forgit checkout_branch`) — not wired to the `**` trigger on plain
`git checkout`/`git switch`.

Goal: type `git checkout **<TAB>` (or `git switch **<TAB>`) and get an fzf
picker of branches/remotes/tags with a `git log` preview, while leaving
every other git completion (all other subcommands, and non-triggered
checkout/switch completion) exactly as it is today — without editing fzf's
own `completion.bash` or bash-completion's `git` completion script.

## Approach

New file: `fzf/git/git-checkout-completion.bash`, sourced from
`fzf/fzf_setup.sh`. It is purely additive — no upstream file is modified.

### Why wrap `_git_checkout`/`_git_switch` instead of the top-level `git` completion

The obvious approach — `complete -F my_fzf_git_completion git` — replaces
*all* git completion (add, commit, log, ...), not just checkout/switch. To
keep everything else working, you'd have to re-detect the subcommand
yourself and fall back to git's real completion for every other case.

Doing that fallback correctly is non-trivial: `git`'s own dispatcher
(`__git_main`, called via `__git_wrap__git_main`) has to skip global options
first (`-C <path>`, `-c name=value`, `--git-dir=`, `--no-pager`, etc.) before
it can even tell which subcommand is being completed. Reimplementing that
parsing invites subtle bugs (e.g. `git -C ~/proj checkout **<TAB>` silently
breaking).

Instead, this script wraps the two functions that bash-completion's own
dispatcher calls once it has *already* resolved the subcommand:
`_git_checkout` and `_git_switch`. Inspecting their real implementation
(via `declare -f`) confirmed they:

- Read `$cur`/`$prev`/`$cword`/`$words` from the caller's scope (bash's
  normal dynamic scoping for locals) rather than taking arguments.
- Already call `__git_has_doubledash` to bail out when completing pathspecs
  after `--` (e.g. `git checkout -- file<TAB>`).
- Already special-case `$prev` being a new-branch-name flag
  (`-b`/`-B`/`--orphan` for checkout; `-c`/`-C`/`--orphan` for switch) before
  falling through to ref completion.

So the wrapper only needs to repeat those same two guard conditions (a
couple of lines, directly mirroring the real function) before deciding
whether to trigger the fzf picker or fall back to the original function —
all the global-option-skipping and subcommand dispatch is still done for
free by bash-completion itself, unmodified.

### Fail-closed loading

Because bash-completion lazily loads git's completion (on first `<TAB>`,
via bash's `-D` dynamic-completion-loader stub), `_git_checkout`/
`_git_switch` may not exist yet when this file is sourced at shell startup.
The script force-loads git's completion first (`_completion_loader git`,
same helper `fzf/git/git-forgit-completions.bash` already relies on, with
fallbacks to `_comp_load`/`__load_completion` for other bash-completion
versions).

If, after that, either function still doesn't exist (unexpected
bash-completion version, git completion not installed, etc.), the script
does **nothing** — it leaves git's completion completely untouched rather
than risk wrapping something incorrectly.

### Idempotency

The whole wrap block is guarded by `declare -F __fzf_git_checkout_orig`, so
sourcing this file multiple times (e.g. in subshells) is a cheap no-op and
never double-wraps.

### Candidate source: branches, remotes, and tags

```bash
git for-each-ref --sort=-committerdate \
    --format=$'%(refname:short)\t%(refname)' \
    refs/heads refs/remotes refs/tags
```

- `for-each-ref` across all three namespaces in one call covers local
  branches, remote-tracking branches, *and* tags — this was requested
  explicitly instead of only listing branches (as `git forgit`'s picker
  does).
- `--sort=-committerdate` surfaces recently-used refs first.
- Both the short name and the full refname are emitted (tab-separated).
  The short name is what gets shown/searched and ultimately inserted on
  the command line; the full refname is only used internally for the
  preview (`git log ... {2}`). This avoids ambiguity if a branch and a tag
  happen to share the same short name — the preview always resolves the
  exact ref that was highlighted, not whichever one `git log <shortname>`
  happens to pick.
- `refs/remotes/*/HEAD` (the symbolic ref pointing at a remote's default
  branch) is filtered out — it's noise, not a real ref to check out.

### Display/insert vs. preview separation

```bash
_fzf_complete --delimiter='\t' --with-nth=1 \
    --preview='git log --color=always --oneline -20 {2}' \
    -- "$@" < <(...)
```

`--with-nth=1` hides the second (full refname) column from the fzf list
and search, while `{2}` in `--preview` still addresses it directly.

`_fzf_complete_git_checkout_ref_post` (fzf's documented
`_fzf_complete_COMMAND_post` convention) strips the selection back down to
just the short name via `awk -F'\t' '{ print $1 }'` before it's inserted
into the command line — you end up with `git checkout main`, not
`git checkout main<TAB>refs/heads/main`.

## Scope / deliberate exclusions

- Only `git checkout` and `git switch` are handled — no aliases (`git co`,
  etc.) and no other subcommands.
- No fallback to fuzzy modified-file listing (like `git forgit
  checkout_file`) — this script is ref-selection only.
- `git forgit`'s smart tracking-branch checkout logic (auto-creating a
  local tracking branch for a selected `remotes/origin/*` ref) is *not*
  reused here. This is a completion function: it can only insert text into
  the command line, it can't run alternate git commands. Plain
  `git checkout <branch>` already auto-sets-up tracking when the name is
  unambiguous, so this is expected to behave sensibly for the common case,
  just without `git forgit`'s explicit `track/<branch>` naming convention
  for ambiguous cases.

## Validation performed

- `bash -n` syntax check on the new script.
- Sourced in an interactive bash shell and confirmed both
  `_git_checkout`/`_git_switch` get wrapped (`__fzf_git_checkout_orig`/
  `__fzf_git_switch_orig` exist).
- Re-sourced the file multiple times to confirm the idempotency guard
  works (no re-wrapping, no errors).
- Ran the `for-each-ref` candidate-source command directly against this
  repo and confirmed it lists local branches, remote branches, and tags
  together, sorted by recency, with no `origin/HEAD` noise.
