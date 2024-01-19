#! /bin/bash

# Open file found via fzf in nvim
bind -x '"\C-p": "$EDITOR $(fzf)"'

# Open browser window
bind -x '"\C-b": "$BROWSER -w"'
