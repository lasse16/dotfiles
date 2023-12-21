require("gitsigns").setup({
	signs = {
		add = { text = " " },
		change = { text = " " },
		delete = { text = " " },
		topdelete = { text = " " },
		changedelete = { text = " " },
		untracked = { text = " " },
	},
	preview_config = {
		border = "rounded",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	on_attach = require("mappings").setup_gitsigns_mappings,
})
