vim.g.packpath = vim.g.runtimepath
require('clipboard')
require('settings')
require('mappings')

vim.cmd('colorscheme updated-default')

vim.cmd([[
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'lilydjwg/colorizer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'rhysd/clever-f.vim'
Plug 'dense-analysis/ale'
Plug '$HOME/src/fzf'
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
if has('python3')
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'puremourning/vimspector'
endif
call plug#end()
]])


print("INIT.LUA completed")
