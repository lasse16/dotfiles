local builtins = require("null-ls").builtins
require("null-ls").setup({
	sources = {
		builtins.diagnostics.actionlint,
		builtins.diagnostics.yamllint,
	},
	update_in_insert = false
})
