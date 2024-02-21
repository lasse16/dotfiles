require('commander').setup({
	prompt_title = "Commands",
	components = {
		"DESC",
		"KEYS",
		"CAT",
	},
	sort_by = {
		"DESC",
		"KEYS",
		"CAT",
		"CMD"
	},
	integration = {
		telescope = {
			enable = true,
		},
		lazy = {
			enable = true,
			set_plugin_name_as_cat = true
		}
	}
})

require("commander").add({
	{
		desc = "Open command palette",
		cmd = require("commander").show,
		keys = { "n", "<C-o>" },
	}
})

local commands = require('commands').default_vim_commands
require("commander").add(commands)
