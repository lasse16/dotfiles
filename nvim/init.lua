vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}")

vim.cmd('let g:python3_host_prog = "/home/lasse/.local/share/nvim/python_environment/bin/python3"')

vim.cmd('let g:netrw_browsex_viewer="wslview"')

vim.g.packpath = vim.g.runtimepath
require("packer-manager")
require("clipboard")
require("settings")
require("mappings")
require("lsp")
require("treesitter")
require("nvim-dap")
require("commands")

vim.cmd("colorscheme updated-default")

print("INIT.LUA completed")
