return {
	{
		"tadmccorkle/markdown.nvim",
		ft = "markdown", -- or 'event = "VeryLazy"'
		opts = {
			mappings = false,
			on_attach = function(bufnr)
				require("mappings").setup_markdown_mappings(bufnr)
			end
		},
	},
}
