local null_ls = require("null-ls")
local formatters = null_ls.builtins.formatting
local linters = null_ls.builtins.diagnostics
local neovim_python_env = "/home/lasse/.local/share/nvim/python_environment/bin/"
null_ls.setup({
	sources = {
		formatters.stylua,
		formatters.black.with({ command = neovim_python_env .. "black" }),
		formatters.shfmt,
		formatters.prettier.with({ disabled_filetypes = { "scss", "css" } }),
		formatters.stylelint,
		linters.shellcheck,
		linters.flake8.with({ command = neovim_python_env .. "flake8", name = "flake8" }),
		linters.pylint.with({ command = neovim_python_env .. "pylint", name = "pylint" }),
		linters.proselint,
		linters.stylelint,
		linters.eslint_d,
		linters.golangci_lint,
	},
	diagnostics_format = "[#{c}] #{m} (#{s})",
	on_attach = function(client)
		require("lsp").on_attach(client, 0)
	end,
})
