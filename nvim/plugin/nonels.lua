local builtins = require("null-ls").builtins
require("null-ls").setup({
	sources = {
		builtins.diagnostics.actionlint,
		builtins.diagnostics.yamllint,
		builtins.code_actions.gitsigns,
		builtins.code_actions.refactoring,
		builtins.diagnostics.vale.with({ extra_filetypes = { "quarto" } }),
		builtins.formatting.alejandra,
		builtins.formatting.yamlfmt,
	},
	update_in_insert = false,
})
