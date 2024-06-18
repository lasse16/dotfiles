local config = require("lsp")

local rust_analyzer_opts = {
	on_attach = config.on_attach,
	capabilities = config.capabilities,
	flags = {
		debounce_text_changes = 200,
	},
	default_settings = {
		["rust-analyzer"] = {
			procMacro = {
				enable = false,
			},
			checkOnSave = {
				command = "clippy",
			},
		},
	},
}

vim.g.rustaceanvim = {
	server = rust_analyzer_opts,
}
