#! /bin/bash

# Open file found via fzf in nvim
bind -x '"\C-p": "file=$(fzf) && $EDITOR $file"'

# Open browser window
bind -x '"\C-b": "$BROWSER -w"'
