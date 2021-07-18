BOOKMARK_FILE="$DOTFILES/bookmarks"

marks(){
	if [ -f $BOOKMARK_FILE ]; then
		local selection=$( cat $BOOKMARK_FILE | fzf  )
		if [ -n $selection ]; then
			cd $selection || exit 1
		else
			echo " No selection made " && exit 1
		fi
	else
		echo " No bookmark file at $BOOKMARK_FILE " && exit 1
	fi
}
