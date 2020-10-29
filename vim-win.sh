function vim-win
{
if [[ $1 ]]
then
	vim "`wslpath "$1"`"
fi
}
