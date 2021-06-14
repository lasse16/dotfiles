#!/bin/bash
export DOTFILES=~/dotfiles

append_bash_history(){
	if [ -f "$HOME/.bash_history" ] ; then
		# Copies the entire bash history upon startup, then sets up a symlink
		cat "$HOME/.bash_history" >> "$DOTFILES/bash/.bash_history"
		rm "$HOME/.bash_history"
	fi
}

# install packages with configurations
cd "$DOTFILES" || exit
append_bash_history;
./dotter deploy

# shellcheck source=/home/lasse/dotfiles/.dotter/cache/.dotter/pre_deploy.sh
# WORKAROUND Currently there is no way of setting environment variables from DOTTER itself
# So, here I am actively sourcing the rendered template of the pre-deploy hook myself.
source "$DOTFILES/.dotter/cache/.dotter/pre_deploy.sh"
exec bash
