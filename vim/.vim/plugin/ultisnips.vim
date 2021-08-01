if has_key(g:plugs,'ultisnips')
	" Unbind this as per default it is bound to <Tab> which conflicts with auto
	" completion
	let g:UltiSnipsExpandTrigger = '<Nop>'
else
	echo printf("Ultisnips config is at %s, but plugin is not installed.", expand( '%:p'))
endif
