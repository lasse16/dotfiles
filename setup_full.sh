#!/bin/bash
export DOTFILES=~/dotfiles

append_bash_history(){
	if [ -f "$HOME/.bash_history" ] ; then
		cat "$HOME/.bash_history" >> "$DOTFILES/bash/.bash_history"
		rm "$HOME/.bash_history"
	fi
}

# install packages with configurations
cd "$DOTFILES" || exit
append_bash_history;
./dotter deploy

exec bash
# # shellcheck source=/home/lasse/dotfiles/.dotter/cache/.dotter/pre_deploy.sh
# source "$DOTFILES/.dotter/cache/.dotter/pre_deploy.sh"

# # shellcheck source=/home/lasse/dotfiles/config_helper.sh
# source "$DOTFILES/config_helper.sh"
