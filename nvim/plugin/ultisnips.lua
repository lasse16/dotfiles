if require("utils").installed("ultisnips") then
	--  	 Unbind this as per default it is bound to <Tab> which conflicts with auto
	--  	 completion
	vim.g.UltiSnipsExpandTrigger = "<Nop>"
end
