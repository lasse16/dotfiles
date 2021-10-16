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
	"$browser_executable" "$1"
}

export -f firefox
