#!/usr/bin/env bash

tmux-list-keys() {
    tmux list-keys -NT prefix -P "$(tmux show -gv prefix) " | fzf
}

export -f tmux-list-keys
