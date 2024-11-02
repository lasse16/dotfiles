vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}")

-- bootstrap lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("settings")
require("lazy").setup({
	-- leave nil when passing the spec as the first argument to setup()
	spec = {
		{
			import = "plugins"
		},
	},
	rocks = {
		enabled = false,
	},
	ui = {
		size = { width = 0.8, height = 0.8 },
		wrap = true,
		border = {
			{ "╭", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╮", "FloatBorder" },
			{ "│", "FloatBorder" },
			{ "╯", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╰", "FloatBorder" },
			{ "│", "FloatBorder" },
		},
		title = "Lazy",
	},
})
require("clipboard")
require("mappings")
require("lsp")
require("treesitter")
require("nvim-dap")
require("commands")

vim.cmd("colorscheme catppuccin-macchiato")
