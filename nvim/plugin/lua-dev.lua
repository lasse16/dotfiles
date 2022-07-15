local lsp_config = require("lspconfig")
local luadev = require("lua-dev").setup({
	lspconfig = {
		cmd = { "/home/lasse/.local/share/lua-lsp/bin/lua-language-server" },
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	},
})

lsp_config.sumneko_lua.setup(luadev)
