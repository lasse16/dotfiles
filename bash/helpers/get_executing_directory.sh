#!/usr/bin/env bash

function get_executing_directory() {
	dirname "$(readlink -f "$0")"
}

export -f get_executing_directory
