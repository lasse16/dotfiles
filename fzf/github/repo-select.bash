#!/usr/bin/env bash

gh-repo-select() {
	gh org list | xargs -l1 gh repo list | cut -f1 | fzf --preview "gh repo view {}" --ansi
}

export -f gh-repo-select
