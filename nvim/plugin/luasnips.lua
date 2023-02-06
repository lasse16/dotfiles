local snip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "html", "css" } })

-- Taken from
-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#snippet-list
vim.api.nvim_create_user_command('Snippets',
	function(opts)
		require('luasnip.extras.snippet_list').open()
	end, {
	desc = "Display all active snippets for this buffer"
})
