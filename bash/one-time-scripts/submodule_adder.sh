input_file=$1
while read -r url directory; do 
	echo "$url $directory"
	git submodule add "$url" "vim/.vim/plugged/$directory"
done < "$input_file"
