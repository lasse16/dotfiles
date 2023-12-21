local lsp = require("lsp")

local shellcheck = require('efmls-configs.linters.shellcheck')
local shfmt = require('efmls-configs.formatters.shfmt')
local stylua = require('efmls-configs.formatters.stylua')


local languages = {
	bash = { shellcheck, shfmt },
	lua = { stylua },
}

require('lspconfig').efm.setup({
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
	}
})
