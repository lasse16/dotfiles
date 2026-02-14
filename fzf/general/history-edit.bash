#!/usr/bin/env bash
history-edit ()
{
    # Backup your history file
    history -w
    HISTFILE=${HISTFILE:-"$HOME/.bash_history"}
    BACKUP="${HISTFILE}.bak"
    cp "$HISTFILE" "$BACKUP"

    # Use fzf to select commands to remove; preview shows the command
    to_remove=$(tac "$HISTFILE" | fzf --multi --preview 'echo {}')
    if [ -z "$to_remove" ]; then
        echo "No commands selected. Exiting."
        exit 0
    fi

    # Create a temporary file for filtered history
    TMPFILE=$(mktemp)

    # Filter out selected commands
    tac "$HISTFILE" | while read -r line; do
    if ! grep -Fxq "$line" <(echo "$to_remove"); then
        echo "$line"
    fi
    done | tac > "$TMPFILE"

    # Replace history file
    mv "$TMPFILE" "$HISTFILE"

    echo "History cleaned. Backup saved to $BACKUP"
}

export -f history-edit
