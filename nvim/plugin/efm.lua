local lsp = require("lsp")

local shellcheck = require("efmls-configs.linters.shellcheck")
local vale = require("efmls-configs.linters.vale")
local yamllint = require("efmls-configs.linters.yamllint")

local stylua = require("efmls-configs.formatters.stylua")
local shfmt = require("efmls-configs.formatters.shfmt")
local prettier_d = require("efmls-configs.formatters.prettier_d")

local languages = {
	bash = { shellcheck, shfmt },
	lua = { stylua },
	markdown = { vale, prettier_d },
	yaml = { prettier_d, yamllint },
}

require("lspconfig").efm.setup({
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
	on_attach = lsp.on_attach,
	capabilities = lsp.capabilities,
	flags = {
		debounce_text_changes = 150,
	},

	filetypes = vim.tbl_keys(languages),
	settings = {
		languages = languages,
	},
})
