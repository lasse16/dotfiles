#!/usr/bin/env bash

irg() {
	local preview=cat
	rg --color=always -n ${list_files:+-l} "$1" 2>/dev/null |
		fzf -d: \
			--ansi \
			--query="$1" \
			--phony \
			--header="" \
			--bind="change:reload:rg -n ${list_files:+-l} --color=always {q}" \
			--bind='enter:execute:v {1}' \
			--preview="[[ -n {1} ]] && $preview"

}
export -f irg
