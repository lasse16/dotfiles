#!/usr/bin/env bash

export DOTFILES_FZF=${DOTFILES_FZF:="$DOTFILES/fzf"}
export FZF_DEFAULT_COMMAND='fd --hidden -I -E ".git"'

# Uncomment when sourcing directly 
source "$DOTFILES_FZF/general/marks.bash"
source "$DOTFILES_FZF/tmux/url-runner.sh"
source "$DOTFILES_FZF/tmux/fzf-tmux.sh"
source "$DOTFILES_FZF/tmux/list-keys.sh"
source "$DOTFILES_FZF/key-bindings.bash"
source "$DOTFILES_FZF/github/repo-select.bash"

# Add subcommands by sourcing files with specific names
pathadd "$DOTFILES_FZF/kubernetes/"
pathadd "$DOTFILES_FZF/git/"
