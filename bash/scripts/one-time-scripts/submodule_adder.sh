input_file=$1
preexisting_folder_path=${2:-"vim/.vim/plugged"}
while read -r url directory; do 
	echo "$url $directory"
	git submodule add "$url" "$preexisting_folder_path/$directory"
done < "$input_file"
