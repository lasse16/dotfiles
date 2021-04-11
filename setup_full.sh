#!/bin/bash
dotfile_directory=$HOME/dotfiles/

stow_bash(){
	if [ -f "$HOME/.bash_history" ] ; then
		cat "$HOME/.bash_history" >> "$dotfile_directory/bash/.bash_history"
		rm "$HOME/.bash_history"
	fi
	stow bash
}

# install packages with configurations
cd "$dotfile_directory"|| exit
stow git
stow_bash
stow direnv
stow tmux
stow vim
stow vifm

source "$dotfile_directory/config_helper.sh"
exec bash
