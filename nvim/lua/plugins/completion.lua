return {
	'saghen/blink.cmp',
	version = '*',
	opts = {
		keymap = { preset = 'default' },
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono'
		},
		sources = {
			default = { 'lsp', 'path', 'luasnip', 'snippets', 'buffer' },
		},
		completion = {
			menu = { border = 'rounded' },
			documentation = { window = { border = 'rounded' } },
		},
		signature = { window = { border = 'rounded' }, enabled = true },
		snippets = {
			expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
			active = function(filter)
				if filter and filter.direction then
					return require('luasnip').jumpable(filter.direction)
				end
				return require('luasnip').in_snippet()
			end,
			jump = function(direction) require('luasnip').jump(direction) end,
		},
	},
	opts_extend = { "sources.default" }
}
