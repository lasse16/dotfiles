export FZF_DEFAULT_OPTS="--reverse --info=inline --border --height=80% --preview-window=:hidden --bind '?:toggle-preview' --preview 'cat {}' --bind 'ctrl-e:execute(echo {+} | xargs -o vim)' "
. $DOTFILES/fzf/bookmark_searcher.sh
