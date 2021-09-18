if vim.fn.has_key(vim.g.plugs, 'ale') then

	-- Change ALEs display symbols
	vim.g.ale_sign_warning ='🞄'
	vim.g.ale_sign_error ='⬤'
	vim.g.ale_sign_info ='!'
	vim.g.ale_virtualtext_prefix =' ◁◁◁◁ '

	vim.g.ale_virtualtext_cursor = 1

	vim.cmd( [[
	let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
]])

	vim.cmd( [[

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
	print(string.format('ALE config present at %s but plugin is not installed', vim.cmd("expand('%:p')")))
end


print('ALE loaded')
