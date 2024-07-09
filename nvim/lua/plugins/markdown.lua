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
	{
		'MeanderingProgrammer/markdown.nvim',
		name = 'render-markdown',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		opts = {
			code = {
				style = 'normal',
				highlight = 'ColorColumn',
			},
			latex = {
				enabled = false
			}
		},
	}
}
