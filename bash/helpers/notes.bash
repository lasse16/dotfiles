#!/usr/bin/env bash

note() {
	local note_directory="$HOME/notes"
	local note_name="$1"

	local current_date="$(date -u +%y%m%d)"
	
	$EDITOR "${note_directory}/${current_date}_${note_name}.md"
}

export -f note
