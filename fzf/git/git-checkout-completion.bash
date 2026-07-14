#!/usr/bin/env bash
# Adds fzf '**' trigger fuzzy completion for `git checkout` and `git switch`
# ref selection (branches, remotes, tags), with a `git log` preview.
#
# This is purely additive: it does not modify fzf's own completion.bash, nor
# bash-completion's git completion script. Instead it wraps bash-completion's
# existing `_git_checkout`/`_git_switch` functions, which already handle
# skipping git's global options, detecting `--` pathspec mode, and excluding
# new-branch-name positions (-b/-B/--orphan etc.) -- we only add our fuzzy
# trigger check in the exact spot where those functions would otherwise fall
# through to normal ref completion. If anything is missing/unexpected, we
# leave git's completion completely untouched (fail closed).

# fzf candidate source for git checkout/switch: branches, remotes and tags,
# most-recently-committed first. Full refname is carried alongside the short
# name (hidden column) so the preview/log is unambiguous even when a branch
# and tag share the same short name.
_fzf_complete_git_checkout_ref() {
    _fzf_complete --delimiter='\t' --with-nth=1 \
        --preview='git log --color=always --oneline -20 {2}' \
        -- "$@" < <(
            git for-each-ref --sort=-committerdate \
                --format=$'%(refname:short)\t%(refname)' \
                refs/heads refs/remotes refs/tags |
                command grep -v -P '\t.*/HEAD$'
        )
}

_fzf_complete_git_checkout_ref_post() {
    command awk -F'\t' '{ print $1 }'
}

# One-time, idempotent setup. Re-sourcing this file is a cheap no-op.
if ! declare -F __fzf_git_checkout_orig >/dev/null; then
    # Make sure git's bash-completion is actually loaded so _git_checkout and
    # _git_switch exist before we try to wrap them.
    if ! declare -F _git_checkout >/dev/null || ! declare -F _git_switch >/dev/null; then
        if type -t _completion_loader >/dev/null 2>&1; then
            _completion_loader git 2>/dev/null
        elif type -t _comp_load >/dev/null 2>&1; then
            _comp_load git 2>/dev/null
        elif type -t __load_completion >/dev/null 2>&1; then
            __load_completion git 2>/dev/null
        fi
    fi

    # Fail closed: only wrap if both functions are really there.
    if declare -F _git_checkout >/dev/null && declare -F _git_switch >/dev/null; then
        eval "$(declare -f _git_checkout | command sed '1s/_git_checkout/__fzf_git_checkout_orig/')"
        eval "$(declare -f _git_switch | command sed '1s/_git_switch/__fzf_git_switch_orig/')"

        _git_checkout() {
            local trigger=${FZF_COMPLETION_TRIGGER-'**'}
            if [[ $cur == *"$trigger" ]] && ! __git_has_doubledash &&
                [[ $prev != -b && $prev != -B && $prev != --orphan ]]; then
                _fzf_complete_git_checkout_ref "git" "$cur" "$prev"
                return
            fi
            __fzf_git_checkout_orig
        }

        _git_switch() {
            local trigger=${FZF_COMPLETION_TRIGGER-'**'}
            if [[ $cur == *"$trigger" ]] && ! __git_has_doubledash &&
                [[ $prev != -c && $prev != -C && $prev != --orphan ]]; then
                _fzf_complete_git_checkout_ref "git" "$cur" "$prev"
                return
            fi
            __fzf_git_switch_orig
        }
    fi
fi
