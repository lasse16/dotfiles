#!/bin/bash

git() {
	if [[ "$1" == "root" ]]; then
		shift
		git_root "$@"
	elif [[ "$1" == "add" ]] && [[ "$2" == "--from-modified" ]]; then
		shift 2
		git_add_from_modified "$@"
	else
		command git "$@"
	fi
}

export -f git
