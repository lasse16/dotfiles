#!/usr/bin/env bash

gh() {
    if [[ "$1" == "repo" ]] && [[ "$2" == "select" ]]; then 
        gh-repo-select
    elif [[ "$1" == "release" ]] && [[ "$2" == "sha" ]]; then
        shift 2
        gh-release-sha
	else
		command gh "$@"
	fi
}

export -f gh
