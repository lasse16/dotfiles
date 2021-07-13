#!/bin/bash

ask_for_dotfile_repo(){
read -e -r -i "$HOME/dotfiles" -p "Where are your dotfiles? " dotfile_candidate

if [[ ! -d "$dotfile_candidate" ]]; then
	echo "$?"
	echo "Given dotfile folder does not exist... Aborting!"
	exit
fi
}


append_bash_history(){
	if [ -f "$HOME/.bash_history" ] ; then
		# Copies the entire bash history upon startup, then sets up a symlink
		cat "$HOME/.bash_history" >> "$DOTFILES/bash/.bash_history"
		rm "$HOME/.bash_history"
	fi
}

# Ask for dotfile repo and set environment variable, Abort if either failed
ask_for_dotfile_repo && export DOTFILES=$dotfile_candidate || exit

# install packages with configurations
cd "$DOTFILES" || exit
append_bash_history;
./dotter deploy

exec bash
