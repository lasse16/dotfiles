return {
	{
		---@module 'snacks'
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			animate = { enabled = false },
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			dim = { enabled = true },
			gitbrowse = { enabled = true },
			indent = { enabled = true },
			input = { enabled = false },
			lazygit = { enabled = false },
			notifier = { enabled = true },
			picker = { enabled = false },
			profiler = { enabled = false },
			quickfile = { enabled = true },
			scope = { enabled = false },
			scratch = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = false },
			terminal = { enabled = true },
			toggle = { enabled = true },
			win = { enabled = true },
			words = { enabled = false },
			zen = { enabled = true },
			styles = {},
		},
		-- open_repo = require('snacks').gitbrowse.open()
		-- show_notifier_history = require('snacks').notifier.show_history()
		-- hide all notifications = Snacks.notifier.hide(id|"all")
		-- enable/disable dimming = Snacks.dim.disable()/.enable()
		-- rename current file = Snacks.rename.rename_file()
		-- toggle_indent_giudes = Snacks.indent.disable()/enable()
		-- open scratch buffer = Snacks.scratch()
		-- select scrawtch buffer = Snacks.scratch.select()
		-- toggle terminal = Snacks.terminal.toggle(cmd, opts)
	},
}
