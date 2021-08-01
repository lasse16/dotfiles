if has_key(g:plugs,'vim-airline')
	" Airline setup
	let g:airline_left_sep = ''
	let g:airline_right_sep = ''
else
	echo printf( "vim airline config present at %s, but plugin is not installed.", expand('%:p') )
endif
