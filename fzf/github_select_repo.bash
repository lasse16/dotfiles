#!/usr/bin/env bash

gh_select_repos() {
	gh org list | xargs -l1 gh repo list | cut -f1 | fzf --preview "gh repo view {}" --ansi
}

export -f gh_select_repos
