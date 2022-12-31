local  neodev = require("neodev").setup({
	-- lspconfig = {
	-- 	cmd = { "/home/lasse/.local/share/lua-lsp/bin/lua-language-server" },
	-- 	on_attach = config.on_attach,
	-- 	capabilities = config.capabilities,
	-- },
})

local lsp_config = require("lspconfig")

lsp_config.sumneko_lua.setup(neodev)
