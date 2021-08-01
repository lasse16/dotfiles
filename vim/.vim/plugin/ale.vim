if has_key(g:plugs,'ale')
	" Disable ALE as its sign column shifts characters some times
	" Disable until fixed an further investigated
	let g:ale_enabled = 0

	" Change ALEs display symbols
	let g:ale_sign_warning ='🞄'
	let g:ale_sign_error ='⬤'

	" Show hints from LSPs too
	let g:ale_lsp_suggestions = 1

	" set up proper linters
	let g:ale_linters = {
				\ 'rust': ['analyzer']
				\}

	let g:ale_fixers = {
				\ 'rust': ['rustfmt'],
				\ '*': ['remove_trailing_lines', 'trim_whitespace']
				\}

	let g:ale_fix_on_save = 1

else
	echo printf("Ale config present at %s but plugin not installed", expand('%:p'))
endif

