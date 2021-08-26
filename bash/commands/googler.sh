google(){
	local google_url="https://www.google.com/search?q="
	$BROWSER "$google_url$*"
}
export -f google
