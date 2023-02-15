#!/bin/bash

export DOTFILES_FZF=${DOTFILES_FZF:="$DOTFILES/fzf"}
export FZF_DEFAULT_COMMAND='fd --hidden -E ".git"'

source "$DOTFILES_FZF/aliases.sh"
source "$DOTFILES_FZF/marks-fzf.sh"
source "$DOTFILES_FZF/pkgsearch-fzf.sh"
source "$DOTFILES_FZF/irg-fzf.sh"
source "$DOTFILES_FZF/tmux-url-parsing-fzf.sh"
