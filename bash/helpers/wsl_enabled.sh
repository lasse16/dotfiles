#!/bin/bash

function is_wsl {
	return grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null
}

export -f is_wsl
