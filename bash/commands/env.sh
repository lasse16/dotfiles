#!/bin/bash

env() {
	if [[ "$1" == "--source" ]]; then
		shift
		source_env ""
	else
		command env "$@"
	fi
}

export -f env

