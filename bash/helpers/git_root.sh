git() {
	if [[ "$1" == "root" ]]; then
		shift
		git_root "$@"
	else
		command git "$@"
	fi
}

git_root() {
	toplevel_directory="$(git rev-parse --show-toplevel)"
	echo "$toplevel_directory"
	for arg in "$@"; do
		case $arg in
		--move | -m)
			cd "$toplevel_directory" || return
			;;
		*)
			echo "Unknown argument"
			;;
		esac
	done
}

export -f git
export -f git_root
