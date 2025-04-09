return {
	{
		"zk-org/zk-nvim",
		opts = {
			picker = "telescope",
			auto_attach = {
				enabled = true,
				filetypes = { "markdown" },
			},
			lsp = {
				on_attach = require("lsp").on_attach,
			}
		}
	}
}
