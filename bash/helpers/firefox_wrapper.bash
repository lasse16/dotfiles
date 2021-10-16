#!/usr/bin/env bash

# --browser          Open a browser window.
# --new-window <url> Open <url> in a new window.
# --new-tab <url>    Open <url> in a new tab.
# --private-window <url> Open <url> in a new private window.
# --preferences      Open Options dialog.
# --screenshot [<path>] Save screenshot to <path> or in working directory.
# --window-size width[,height] Width and optionally height of screenshot.
# --search <term>    Search <term> with your default search engine.

firefox() {
	local browser_executable=/mnt/c/'Program Files'/'Mozilla Firefox'/firefox.exe

	# Replace -t and -w with their long options
	local replaced_tabs
	replaced_tabs=${*//\ -t/\ --new-tab}

	local replaced_windows
	replaced_windows=${replaced_tabs//\ -w/\ --new-window}

	local final_args=$replaced_windows
	echo "$final_args"
	"$browser_executable" "$final_args"
}

export -f firefox
