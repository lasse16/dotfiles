#!/bin/bash

function is_wsl {
	[[ "$(uname -r)" == *"WSL"* ]]
	return
}

export -f is_wsl
