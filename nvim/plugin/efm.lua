local lsp = require("lsp")

local shellcheck = require('efmls-configs.linters.shellcheck')
local shfmt = require('efmls-configs.formatters.shfmt')

local languages = {
	bash = { shellcheck, shfmt },
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
-- 		Leftovers from null_ls.lua
-- 		formatters.stylua,
-- 		formatters.black.with({ command = neovim_python_env .. "black" }),
-- 		formatters.shfmt,
-- 		formatters.prettier.with({ disabled_filetypes = { "scss", "css" } }),
-- 		formatters.stylelint,
-- 		linters.shellcheck,
-- 		linters.flake8.with({ command = neovim_python_env .. "flake8", name = "flake8" }),
-- 		linters.pylint.with({ command = neovim_python_env .. "pylint", name = "pylint" }),
-- 		linters.proselint,
-- 		linters.stylelint,
-- 		linters.eslint_d,
-- 		linters.golangci_lint,
