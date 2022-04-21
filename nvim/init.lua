vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}")

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
