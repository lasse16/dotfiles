#!/usr/bin/env bash

export DOTFILES_FZF=${DOTFILES_FZF:="$DOTFILES/fzf"}
export FZF_DEFAULT_COMMAND='fd --hidden -E ".git"'

# Uncomment when sourcing directly 
source "$DOTFILES_FZF/aliases.sh"
source "$DOTFILES_FZF/marks-fzf.sh"
source "$DOTFILES_FZF/pkgsearch-fzf.sh"
source "$DOTFILES_FZF/tmux-url-parsing-fzf.sh"
source "$DOTFILES_FZF/fzf-tmux.sh"
source "$DOTFILES_FZF/key-bindings.bash"
source "$DOTFILES_FZF/interactive-ripgrep.bash"
source "$DOTFILES_FZF/github_select_repo.bash"

# Add subcommands by sourcing files with specific names
pathadd "$DOTFILES_FZF/kubernetes/"
pathadd "$DOTFILES_FZF/git/"
