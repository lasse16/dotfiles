#! /bin/bash

# Open file found via fzf in nvim
bind -x '"\C-f": "nvim $(fzf)"'

# Open browser window TODO hardcoded to firefox
bind -x '"\C-b": "firefox -w"'
