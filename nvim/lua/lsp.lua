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
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	require("mappings").set_lsp_keymappings(bufnr)

	-- Draw hover and signature help windows with a specified border
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

	-- Disable LSP diagnostics as ALE handles displaying those
	require("nvim-ale-diagnostic")
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = false,
		virtual_text = false,
		signs = true,
		update_in_insert = false,
	})
end

-- Setup completion engine
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

print("LSP config finished")

config = {
	on_attach = on_attach,
	capabilites = capabilities,
}

-- Setup default config for specified servers
local server_with_default_setup = { "pyright", "bashls", "ansiblels" }
for _, lsp in ipairs(server_with_default_setup) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilites = capabilites,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

return config
