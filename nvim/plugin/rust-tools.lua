local config = require("lsp")

local rust_analyzer_opts = {
	on_attach = config.on_attach,
	capabilities = config.capabilities,
	flags = {
		debounce_text_changes = 200,
	},
	settings = {
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

local rust_tools_options = {
	tools = {
		hover_with_actions = false,
		runnables = {
			use_telescope = false,
		},
		debuggables = {
			use_telescope = false,
		},
	},
}

require("rust-tools").setup({
	server = rust_analyzer_opts,
	tools = rust_tools_options,
	dap = {
		adapter = require("dap").adapters.lldb,
	},
})

print("Rust-tools setup finished")
