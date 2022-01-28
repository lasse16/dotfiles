vim.cmd([[
call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp', { 'branch' : 'main' }
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch' : 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch' : 'main' }
Plug 'hrsh7th/cmp-path', { 'branch' : 'main' }
Plug 'hrsh7th/cmp-omni', { 'branch' : 'main' }
Plug 'quangnguyen30192/cmp-nvim-ultisnips', { 'branch' : 'main' }
Plug 'junegunn/vim-easy-align'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lilydjwg/colorizer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'rhysd/clever-f.vim'
Plug '$HOME/src/fzf'
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kosayoda/nvim-lightbulb'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'mizlan/iswap.nvim'
Plug 'soywod/himalaya', {'rtp': 'vim'}
Plug 'jose-elias-alvarez/null-ls.nvim', {'branch' : 'main'}
Plug 'ThePrimeagen/harpoon'
Plug 'rcarriga/nvim-notify'
Plug 'folke/trouble.nvim', {'branch' : 'main'}
Plug 'stevearc/dressing.nvim'
call plug#end()
]])

vim.g.packpath = vim.g.runtimepath
require("clipboard")
require("settings")
require("mappings")
require("lsp")
require("treesitter")
require("nvim-dap")
require("commands")

vim.cmd("colorscheme updated-default")

vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}")

vim.cmd(' let g:python3_host_prog = "/home/lasse/.local/share/nvim/python_environment/bin/python3"')

vim.cmd('let g:netrw_browsex_viewer="wslview"')

print("INIT.LUA completed")
