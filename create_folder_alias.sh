while read -r line;do
	folder_name=$(basename $line);
	folder_name_uppercase=$(echo $folder_name | tr  '[:lower:]' '[:upper:]')
	folder_name_lowercase=$(echo $folder_name | tr '[:upper:]' '[:lower:]')
	export $folder_name_uppercase=$line;
	alias $folder_name_lowercase="cd $line"
true;
done < "$DOTFILES/folder_shortcuts"
