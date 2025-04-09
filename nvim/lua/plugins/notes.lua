return {
	{
		"zk-org/zk-nvim",
		config = function()
			require("zk").setup({
				picker = "telescope",
				auto_attach = {
					enabled = true,
					filetypes = { "markdown" },
				},
				lsp = {
					on_attach = require("lsp").on_attach,
				}
			})
		end,
	}
}
