for directory in $(ls -d ./*/);	do	
				cd "$directory"
				url=$(git remote get-url "$(git remote)")
				echo "$url"
				directory_name=${PWD##*/}
				cd ..
				echo "$url $directory_name/" >> urls.txt
done
