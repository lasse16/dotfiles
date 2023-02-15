#!/usr/bin/env bash

tmux_url_parse() {

	fzf_filter() {
		local fzf_options='-d 35% -m -0 --no-preview --no-border'
		eval "fzf-tmux $fzf_options"
	}

	open_url() {
		nohup "$BROWSER" "$@"
	}

	content="$(tmux capture-pane -J -p)"

	urls=$(echo "$content" | grep -oE '(https?|ftp|file):/?//[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]')
	wwws=$(echo "$content" | grep -oE '(http?s://)?www\.[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}(/\S+)*' | grep -vE '^https?://' | sed 's/^\(.*\)$/http:\/\/\1/')
	ips=$(echo "$content" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}(:[0-9]{1,5})?(/\S+)*' | sed 's/^\(.*\)$/http:\/\/\1/')
	gits=$(echo "$content" | grep -oE '(ssh://)?git@\S*' | sed 's/:/\//g' | sed 's/^\(ssh\/\/\/\)\{0,1\}git@\(.*\)$/https:\/\/\2/')
	gh=$(echo "$content" | grep -oE "['\"]([A-Za-z0-9-]*/[.A-Za-z0-9-]*)['\"]" | sed "s/'\|\"//g" | sed 's#.#https://github.com/&#')

	items=$(
		printf '%s\n' "${urls[@]}" "${wwws[@]}" "${gh[@]}" "${ips[@]}" "${gits[@]}" |
			grep -v '^$' |
			sort -u |
			nl -w3 -s '  '
	)

	if [[ -z "$items" ]]; then
		tmux display -p 'tmux-fzf-url: no URLs found'
	else
		fzf_filter <<<"$items" | awk '{print $2}' |
			while read -r chosen; do
				open_url "$chosen" &>"/tmp/tmux-$(id -u)-fzf-url.log"
			done
	fi	

}
export -f tmux_url_parse
