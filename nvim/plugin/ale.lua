if vim.fn.has_key(vim.g.plugs, "ale") then
	-- Change ALEs display symbols
	vim.g.ale_set_highlights = 1
	vim.g.ale_set_signs = 1
	vim.g.ale_sign_warning = "w"
	vim.g.ale_sign_error = "e"
	vim.g.ale_sign_info = "!"
	vim.g.ale_virtualtext_prefix = " ◁◁◁◁ "

	vim.g.ale_virtualtext_cursor = 1
	vim.g.ale_detail_to_floating_preview = 1

	-- Only use defined linters
	vim.g.ale_linters_explicit = 1

	-- Border characters
	vim.g.ale_floating_window_border = { "│", "─", "╭", "╮", "╯", "╰" }

	-- Do not lint on entering a new file
	vim.g.ale_lint_on_enter = 0

	local ale_fixers = {}
	ale_fixers["*"] = { "remove_trailing_lines", "trim_whitespace" }
	ale_fixers["sh"] = { "shfmt", "remove_trailing_lines", "trim_whitespace" }
	ale_fixers["python"] = { "black", "remove_trailing_lines", "trim_whitespace" }
	ale_fixers["lua"] = { "stylua", "remove_trailing_lines", "trim_whitespace" }
	ale_fixers["javascript"] = { "prettier-standard" }
	ale_fixers["rust"] = { "rustfmt" }
	vim.g.ale_fixers = ale_fixers

	-- nvim-lsp is always displayed as an external source
	local ale_linters = {}
	ale_linters["sh"] = { "shellcheck" }
	ale_linters["python"] = { "flake8", "pylint" }
	ale_linters["javascript"] = { "prettier-standard" }
	ale_linters["rust"] = { "cargo" }
	vim.g.ale_linters = ale_linters

	-- Additional linter setup
	vim.g.ale_python_pylint_executable = "/home/lasse/.local/share/nvim/python_environment/bin/pylint"
	vim.g.ale_python_flake8_executable = "/home/lasse/.local/share/nvim/python_environment/bin/flake8"

	-- Additional fixer setup
	vim.g.ale_sh_shellcheck_options = "-x"
	vim.g.ale_python_black_executable = "/home/lasse/.local/share/nvim/python_environment/bin/black"

	vim.g.ale_rust_cargo_use_clippy = vim.fn.executable("cargo-clippy")
	vim.cmd([[

	highlight link ALEError LspDiagnosticsDefaultError
  highlight link ALEWarning LspDiagnosticsDefaultWarning
  highlight link ALEInfo LspDiagnosticsDefaultInformation

	highlight link ALEErrorSign LspDiagnosticsSignError
	highlight link ALEWarningSign LspDiagnosticsSignWarning
	highlight link ALEInfoSign LspDiagnosticsSignInformation

  highlight link ALEVirtualTextError LspDiagnosticsVirtualTextError
  highlight link ALEVirtualTextWarning LspDiagnosticsVirtualTextWarning
  highlight link ALEVirtualTextInfo LspDiagnosticsVirtualTextInformation

]])

	vim.g.ale_fix_on_save = 1

	-- Disable LSP features as they are handled by nvim-lspconfig
	vim.g.ale_disable_lsp = 1
else
	print(string.format("ALE config present at %s but plugin is not installed", vim.cmd("expand('%:p')")))
end

print("ALE loaded")
