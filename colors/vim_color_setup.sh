vim_colorscheme_directory="$DOTFILES"/vim/.vim/colors
mkdir "$vim_colorscheme_directory"
cd  "$vim_colorscheme_directory " || exit
ln -s "$DOTFILES"/colors/updated-default.vim updated-default.vim
