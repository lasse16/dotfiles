if vim.fn.has_key(vim.g.plugs, 'ale') then

	-- Change ALEs display symbols
	vim.g.ale_sign_warning ='🞄'
	vim.g.ale_sign_error ='⬤'

	vim.cmd( [[
	let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
]])

	vim.g.ale_fix_on_save = 1
else
	print(string.format('ALE config present at %s but plugin is not installed', vim.cmd("expand('%:p')")))
end


print('ALE loaded')
