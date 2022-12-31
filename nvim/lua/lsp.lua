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

	-- Mappings.
	require("mappings").set_lsp_keymappings(bufnr)

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
	if client.resolved_capabilities.document_formatting then
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
	"pyright",
	"jedi_language_server",
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

return config
