#!/bin/bash

export DOTFILES_FZF=${DOTFILES_FZF:="$DOTFILES/fzf"}
export FZF_DEFAULT_COMMAND='fd --hidden -E ".git"'
