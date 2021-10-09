shellcheck_wiki() {
	local shellcheck_wiki_url="http://github.com/koalaman/shellcheck/wiki/"

	for shellcheck_wiki_code in "$@"; do
		$BROWSER "$shellcheck_wiki_url$shellcheck_wiki_code"
	done
}
export -f shellcheck_wiki
