#!/bin/bash

nix() {
	if [[ "$1" == "packages" ]]; then
		shift
		jq -r '.elements[].attrPath' ~/.nix-profile/manifest.json | fzf --preview 'jq --arg attr {} ".elements[] | select(.attrPath == \$attr)" ~/.nix-profile/manifest.json'

	else
		command nix "$@"
	fi
}

export -f nix
