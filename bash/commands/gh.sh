#!/usr/bin/env bash

gh() {
    if [[ "$1" == "repo" ]] && [[ "$2" == "select" ]]; then 
        gh-repo-select
	else
		command gh "$@"
	fi
}

export -f gh
