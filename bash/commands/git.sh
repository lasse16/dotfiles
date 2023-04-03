#!/bin/bash

git() {
	if [[ "$1" == "root" ]]; then
		shift
		git_root "$@"
	else
		command git "$@"
	fi
}

export -f git
