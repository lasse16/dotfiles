require("lazydev").setup({})

local lsp_config = require("lspconfig")
local lsp = require("lsp")

lsp_config.lua_ls.setup({
	on_attach = lsp.on_attach,
	capabilities = lsp.capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
            completion = {
                callSnippets = "Replace",
            },
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
