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
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
		{ border = border })

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
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

	vim.lsp.inlay_hint.enable(true)
end

-- Setup completion engine
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

config = {
	on_attach = on_attach,
	capabilites = capabilities,
}

-- Setup default config for specified servers
local server_with_default_setup = {
	"pylsp",
	"ansiblels",
	"tsserver",
	"emmet_ls",
	"taplo",
	"nil_ls",
	"jsonls",
	"cssls",
	"terraformls",
	"tflint",
	"gopls",
	"ltex",
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

require("lspconfig").yamlls.setup({
	on_attach = on_attach,
	capabilites = capabilites,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		yaml = {
			format =
			{
				enable = true
			},
			validate =
			{
				enable = true
			},
			completion =
			{
				enable = true
			},
			hover =
			{
				enable = true
			},
			schemaStore =
			{
				enable = true
			},
		}
	}
})

require("lspconfig").marksman.setup({
	on_attach = on_attach,
	capabilites = capabilites,
	flags = {
		debounce_text_changes = 150,
	},
	filetypes = { "markdown", "quarto" },
	root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
})

return config
