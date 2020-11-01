#/bin/sh
# Write a script that allows for shortcut calls ala 'config vim' to open .vimrc in favourite editor
DOTFILE_FOLDER="$HOME/dotfiles"
config ()
{
	if  [[ $1 ]]
	then 	
		local config_folder=$1
		local config_file=".$1rc"
		echo "$DOTFILE_FOLDER"
		if [[ $2 ]] 
		then
			config_file=$2
		fi
		
		local full_path="$DOTFILE_FOLDER/$config_folder/$config_file"
		if [[ -f $full_path ]] 
		then 
			echo "Opening file at $full_path"
			$EDITOR $full_path
		else
			echo "No file found at $full_path"
		fi
	fi
}
export -f config
