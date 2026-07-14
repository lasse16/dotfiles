# Migrating package installation to Home Manager (keeping Dotter)

This document records the decisions behind moving package *installation* to
Nix Home Manager while keeping Dotter for everything it already does well
(templating and symlinking), along with the reasoning and the concrete
migration plan.

## Context

Dotter currently handles three things:

1. **Package selection per host** — `.dotter/local.toml`'s `packages = [...]`
   list picks which config "packages" (from `.dotter/global.toml`) get
   deployed on a given machine.
2. **Machine-specific variables** — `local.toml`'s `[variables]` (git email,
   SSH key paths, cargo/rustup home, etc.).
3. **Templating & symlinking** — `.tmpl` files use small Handlebars
   conditionals (e.g. `{{#if dotter.packages.gpg}}`) and variable
   substitution, then get rendered/symlinked into place.

NixOS/Home Manager could replace all three, but its idiomatic style
(`programs.git.extraConfig`, `programs.bash.initExtra`, etc. as Nix
attrsets/strings) would absorb already-plain, readable config files into Nix
syntax. That directly conflicts with the goal of dotfiles being
self-explanatory without Nix knowledge.

## Decisions

### 1. Scope: NixOS/WSL host only, for now
No other machines currently run this dotfiles repo, so we don't need
Home Manager to work standalone on non-NixOS systems yet. The design below
doesn't preclude it later — Home Manager configs are portable — but nothing
extra is being built for that case right now.

### 2. Style: keep files and templates exactly as they are
`.tmpl` files, their Handlebars conditionals, and the "plain, readable
without touching Nix" property are all preserved unchanged. Home Manager is
**not** used to generate config content, and no `programs.*` module options
are adopted for things Dotter already templates. Home Manager's role is
scoped strictly to **installing packages**.

Rationale: this was the explicit thing you didn't want to lose. Splitting
conditionals out into separate snippet files (an alternative considered)
would still add indirection and a second thing to learn; keeping Dotter as
the one and only templating engine is simpler and changes nothing you
already rely on.

### 3. Single source of truth for package lists: a new tracked `packages.toml`
**Revised after review (see "Rubber-duck review" below).** The original idea
was to have Home Manager read `.dotter/local.toml` directly. That file is
gitignored (it holds host-specific secrets/paths: git email, SSH key paths,
GPG key ID), and gitignored files are invisible to flake evaluation even via
relative paths — verified empirically, `builtins.readFile ./local.toml`
fails with "No such file" inside `nix eval` because Nix's git-aware source
filtering excludes it before the build even starts.

Instead, package **selection** (the list of names, not the secret
variables) moves into a new small file that's safe to commit — e.g.
`.dotter/packages.toml`:
```toml
packages = ["bash", "direnv", "git", "starship", ...]
```
- Dotter's `local-config` flag points at this file for the `packages` key
  (Dotter supports `-l/--local-config <path>` to relocate it), OR the two
  files are merged via Dotter's `-p/--patch` stdin-patch feature — either
  way `local.toml` keeps owning `[variables]` (the actual secrets/paths) and
  never needs to be read by Nix.
- Home Manager reads only `packages.toml` (tracked, safe to be part of the
  flake's normal git-aware source copy — no `--impure` needed) and resolves
  each name via `package-map.nix`, same as originally planned.

Rationale: avoids drift between "packages Dotter templates for" and
"packages Nix installs" — there is exactly one list to edit per host — while
keeping secrets out of anything Nix touches. Missing/unmapped package names
still cause a Nix evaluation error rather than silently being skipped, which
forces a deliberate decision the first time a new package is added.

### 4. Home Manager runs standalone, not as a NixOS module
Home Manager will be wired as its own flake output
(`homeConfigurations.lasse`) applied via `home-manager switch`, rather than
imported as a module inside `nixos/configuration.nix` and applied through
`nixos-rebuild switch`.

Rationale — this is where the real benefit of Home Manager over Dotter for
package management comes from:

| | System packages (`configuration.nix`) | Home Manager (standalone) |
|---|---|---|
| Applied by | `nixos-rebuild switch` (needs root, rebuilds whole system closure) | `home-manager switch` (no root, only rebuilds your user profile — much faster) |
| Nixpkgs version | Locked to whatever input the system flake pins | Can pin an independent nixpkgs input just for your user tools (e.g. track unstable for a newer neovim without touching the system) |
| Rollback | Tied to system generations | Independent generations, doesn't touch system state |
| Scope | All users; required for services/root-level things (podman, openssh, hardware) | Just your user; can't manage system services |

Since the whole point of adding Nix here was faster iteration on
frequently-updated CLI tools, using Home Manager as a NixOS module (still
gated behind a full `nixos-rebuild`) would have thrown away that benefit.

### 5. Per-package decision: system-level vs. `home.packages`
Not all-or-nothing — each package is judged individually:

- **Move to `home.packages`**: fast-moving user CLI tools you want to
  update independently of the system — `neovim`, `starship`, `fzf`, `tmux`,
  `direnv`, `eza`, `fd`, `gh`, `ripgrep`, `git-trim`, `just`, and the rest of
  the Dotter-managed tool packages (`zk`, `git-cliff`, `khard`, `himalaya`,
  `alacritty`, yaml formatters/linters, etc.).
- **Keep at system level** (`configuration.nix`): things needing root,
  system services, or shared-across-users behavior — `podman`, `openssh`,
  `wslu`, the GnuPG agent service configuration.
- Packages already present in both places (e.g. `neovim`, `starship`,
  `fzf`, `tmux`, `direnv` currently live in
  `users.users.lasse.packages`) get removed from `configuration.nix` once
  confirmed working through Home Manager, so each binary has exactly one
  place it's declared.

### 6. "Template-only" Dotter packages need no Nix package at all
`ssh`, `environment`, and `nixos` are Dotter "packages" purely in the sense
of triggering templating/variables/symlinks — they map to an empty list in
`package-map.nix` and Home Manager does nothing for them.

### 7. Migrate incrementally; Dotter stays fully functional throughout
Home Manager is purely additive at every step. Nothing about `dotter
deploy` changes or breaks while packages are migrated one at a time, so the
migration can pause/resume at any point without leaving the machine in a
broken state.

### 8. `dotter deploy` stays an explicit step, not a Home Manager activation hook
**Revised after review.** The original idea of running `./dotter deploy`
from a `home.activation` hook is dropped. Reasons: activation runs
non-interactively with no guarantee of working directory or `$DOTFILES`
being set the way an interactive shell has it; some Dotter-managed targets
are root-owned (`/etc/nixos/configuration.nix`, `/etc/nixos/flake.nix`),
which is a mismatch for a deliberately rootless `home-manager switch`; and
failures inside activation hooks are more awkward to diagnose than a
top-level command failing.

Instead, a plain wrapper command (a `justfile` recipe) runs both steps
explicitly and in order:
```
just home   # -> home-manager switch --flake ./nixos#lasse && cd ~/dotfiles && ./dotter deploy
```
This keeps the "one command" convenience without hiding imperative,
repo-path-dependent behavior inside a Nix activation script.

## Plan

### Structure being introduced
```
.dotter/
  packages.toml          # NEW, tracked: just `packages = [...]`, no secrets
  local.toml              # unchanged, gitignored: [variables] + packages
                          #   (Dotter merges/points at packages.toml for the list;
                          #    exact merge mechanism decided during phase 1)
nixos/
  flake.nix            # add home-manager input + homeConfigurations.lasse output
  configuration.nix     # unchanged except removing packages moved to Home Manager
home-manager/
  home.nix              # entry point: username, homeDirectory, stateVersion,
                         # imports packages.nix
  packages.nix          # reads .dotter/packages.toml, resolves via package-map.nix
  package-map.nix        # explicit dotter-package-name -> [nixpkgs packages] table
justfile                 # new `home` recipe: home-manager switch + dotter deploy
```

### Rollout order
1. **Bootstrap plumbing** — add the `home-manager` flake input and
   `homeConfigurations.lasse` output; create `home-manager/home.nix` with
   just username/homeDirectory/stateVersion and an empty package set; verify
   `home-manager switch --flake ./nixos#lasse` succeeds before installing
   anything real. Also create `.dotter/packages.toml` and confirm Dotter
   still deploys correctly with the package list split out of `local.toml`.
2. **Wire `packages.toml` parsing** — `packages.nix` reads the tracked TOML
   and looks up each entry in `package-map.nix`; unmapped entries error out.
3. **Low-risk packages first** — populate the map for packages with no
   overlap in `configuration.nix` and no tricky install story: `zk`,
   `git-cliff`, `khard`, `himalaya`, `alacritty`, yaml formatters/linters.
4. **Packages duplicated in `configuration.nix`** — migrate one at a time:
   `fzf`, `tmux`, `direnv`, `starship`, `nvim`; after each is confirmed
   working via Home Manager, remove it from
   `users.users.lasse.packages` in `configuration.nix`.
5. **Trickier tooling** — `rust` (decide toolchain strategy: rustup vs.
   pinned toolchain — current `local.toml` vars only set
   `cargo_home`/`rustup_home` env dirs and are unaffected either way),
   `volta`, `go`, `tree-sitter`, `opencode` (confirm nixpkgs availability),
   `gpg` (only the binary moves; `programs.gnupg.agent` stays a system-level
   service in `configuration.nix`).
6. **Remaining system-only CLI tools** — move `eza`, `fd`, `gh`,
   `ripgrep`, `git-trim`, `just` out of `configuration.nix` into
   `home.packages`.
7. **No-op map entries** — set `ssh`, `environment`, `nixos` to `[]` in
   `package-map.nix`.
8. **Polish** — add a `home` recipe to the `justfile` that runs
   `home-manager switch` followed by `./dotter deploy` (see decision #8 —
   deliberately not a Home Manager activation hook); update `README.md` to
   document the two-step workflow; do a clean sanity check of the full
   bootstrap flow.

## Alternatives considered for templating itself

Before settling on "keep Dotter", I checked whether Nix/NixOS/Home Manager
has any native mechanism for Dotter-style templating (plain files with
in-file conditionals, no Nix syntax required to read them). It doesn't —
Home Manager's own answer to templating *is* the Nix language
(`programs.*` options, `home.file.<path>.text`, `pkgs.substituteAll`), which
is exactly the opacity this migration is trying to avoid. There's no
`programs.chezmoi`-style module or built-in "render this template" option in
Home Manager (confirmed via the Home Manager options index).

The realistic external tools that do this kind of templating are Dotter
(current) or **chezmoi** (Go templates, more popular/actively maintained,
commonly paired with Home Manager in public dotfiles repos for exactly this
package-vs-template split). Switching to chezmoi would mean rewriting every
`.tmpl` file's conditionals into Go template syntax for no functional gain —
**decision: keep Dotter**, since it already does the job and nothing native
or obviously better exists to replace it with.

## Rubber-duck review

Had this plan independently reviewed before implementing. Key findings and
how they were resolved:

- **Reading `local.toml` from Nix is broken as originally planned** —
  confirmed by testing: gitignored files are invisible to flake evaluation
  even via relative paths (`nix eval` fails with "No such file", because
  Nix's git-aware source filtering excludes gitignored paths before the
  build runs). Led to decision #3 above (new tracked `packages.toml`).
- **Claim that `home-manager/` as a sibling of `.dotter/`/`nixos/` (outside
  the flake root) would be unreachable — tested and found incorrect.** Nix
  copies the whole git-tracked repository into the store regardless of which
  subdirectory contains `flake.nix`; a relative path like
  `../home-manager/home.nix` resolves fine as long as the target file is
  git-tracked. The sibling-directory structure itself was never the
  problem — only the gitignored file was. Structure kept as originally
  planned.
- **`home.activation` running `dotter deploy` is fragile** — agreed, dropped
  in favor of an explicit wrapper command (decision #8 above).
- **Duplicate binaries during the incremental migration window** (same tool
  installed via both `configuration.nix` and `home.packages` temporarily) —
  low risk, but worth a quick sanity check with `type -a <tool>` /
  `readlink -f "$(command -v <tool>)"` after each package migration to
  confirm which profile is winning on `PATH`.
- **"Hard error on unmapped package" could get noisy in phase 2 if every
  package isn't pre-classified** — addressed by explicitly bucketing every
  entry from `global.toml` up front into "installs a package", "system-owned
  no-op", or "template-only no-op" as part of writing `package-map.nix`,
  rather than discovering gaps one `home-manager switch` at a time.

## Open items to confirm during execution
- Decide exactly how Dotter merges `packages.toml` + `local.toml` (via
  `-l/--local-config` pointing Dotter itself at `packages.toml` with
  `local.toml` reduced to `[variables]` only, or Dotter's `-p/--patch` stdin
  merge, or Dotter simply keeps reading `local.toml` as-is and
  `packages.toml` becomes a duplicate list Dotter doesn't consume at all,
  purely for Home Manager) — settle this in phase 1.
- Verify nixpkgs attribute names exist for less-common tools (`himalaya`,
  `khard`, `zk`, `opencode`, `git-cliff`, `tree-sitter`) before mapping them.
- Decide the Rust toolchain strategy (`rustup` vs. `pkgs.rustc`/`pkgs.cargo`
  vs. a Rust overlay).
- No `.tmpl` file changes are in scope for this migration.
