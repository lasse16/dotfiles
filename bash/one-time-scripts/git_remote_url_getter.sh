#!/usr/bin/env sh
path_to_directory=$1
for directory in "$path_to_directory"/*/;	do	
				cd "$directory" || exit
				url=$(git remote get-url "$(git remote)")
				echo "$url"
				directory_name=${PWD##*/}
				cd ..
				echo "$url $directory_name/" >> urls.txt
done
