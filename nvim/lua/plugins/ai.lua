return {
	{

		"olimorris/codecompanion.nvim",
		opts = {
			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						show_result_in_chat = true, -- Show mcp tool results in chat
						make_vars = true, -- Convert resources to #variables
						make_slash_commands = true, -- Add prompts as /slash commands
					},
				},
			},
		},
		config = function(_, opts)
			require("codecompanion").setup(opts)
			require("mappings").setup_code_companion_mappings()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"github/copilot.vim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/mcphub.nvim",
		},
	},
	{
		"ravitemer/mcphub.nvim",
		opts = {},
	},
}
