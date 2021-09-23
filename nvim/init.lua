vim.cmd([[
call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp', { 'branch' : 'main' }
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch' : 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch' : 'main' }
Plug 'hrsh7th/cmp-path', { 'branch' : 'main' }
Plug 'quangnguyen30192/cmp-nvim-ultisnips', { 'branch' : 'main' }
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
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'puremourning/vimspector'
Plug 'kosayoda/nvim-lightbulb'
Plug 'nathanmsmith/nvim-ale-diagnostic', { 'branch' : 'main' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()
]])

vim.g.packpath = vim.g.runtimepath
require('clipboard')
require('settings')
require('mappings')
require('lsp')
require('treesitter')

vim.cmd('colorscheme updated-default')

vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}')

vim.cmd(' let g:python3_host_prog = "/home/lasse/.local/share/nvim/python_environment/bin/python3"')

print("INIT.LUA completed")
