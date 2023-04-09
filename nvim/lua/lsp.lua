local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}

local on_attach = function(client, bufnr)
	require("mappings").set_lsp_keymappings()

	-- Draw hover and signature help windows with a specified border
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = false,
		virtual_text = true,
		signs = true,
		update_in_insert = false,
	})

	vim.diagnostic.config({
		virtual_text = {
			prefix = "◁◁◁◁ ",
		},
	})

	-- If LSP-Server can format, format on write
	if client.server_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
end

-- Setup completion engine
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

print("LSP config finished")

config = {
	on_attach = on_attach,
	capabilites = capabilities,
}

-- Setup default config for specified servers
local server_with_default_setup = {
	"pylsp",
	"bashls",
	"ansiblels",
	"tsserver",
	"emmet_ls",
	"taplo",
	"jsonls",
	"cssls",
	"marksman",
	"terraformls",
	"gopls",
}
for _, lsp in ipairs(server_with_default_setup) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilites = capabilites,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

local lsp_config = require("lspconfig")

lsp_config.sumneko_lua.setup({
	cmd = { "/home/lasse/.local/share/lua-lsp/bin/lua-language-server" },
	on_attach = config.on_attach,
	capabilities = config.capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
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
	}
})

return config
