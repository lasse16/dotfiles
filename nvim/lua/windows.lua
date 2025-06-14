-- Configuration for certain floating windows
local M = {}

M.help_window = require("snacks").win({
	width = 0.9,
	height = 0.9,
	position = "float",
	title = " Help ",
	title_pos = "center",
	border = "rounded",
	bo = {
		buftype = "help",
		readonly = true,
	},
	show = false,
	wo = {
		signcolumn = "yes:9",
		statuscolumn = " ",
		conceallevel = 0,
	},
})

-- TODO: Fix windows creating each other
-- When calling this module for creating any window mentioned here,
-- it automatically calls the rest of the module as well, creating all those windows too.
-- i.e. opning the help window opens the news window as well
M.news_window = require("snacks").win({
	file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
	width = 0.6,
	height = 0.6,
	wo = {
		spell = false,
		wrap = false,
		signcolumn = "yes",
		statuscolumn = " ",
		conceallevel = 0,
	},
	bo = {
		readonly = true,
	},
	show = false,
	border = "rounded",
})

return M
