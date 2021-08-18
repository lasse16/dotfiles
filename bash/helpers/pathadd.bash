#!/usr/bin/env bash
pathadd() {
    local abs_path=$(realpath "$1")
    if [ -d "$abs_path" ] && [[ ":$PATH:" != *":$abs_path:"* ]]; then
        PATH="${PATH:+"$PATH:"}$abs_path"
    fi
}
export -f pathadd
