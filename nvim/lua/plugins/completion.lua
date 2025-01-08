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
			menu = { auto_show = false, border = 'rounded' },
			documentation = { auto_show = true, auto_show_delay_ms = 50, window = { border = 'rounded' } },
			list = { selection = { preselect = false, auto_insert = false } },
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
