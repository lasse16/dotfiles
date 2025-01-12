return {
	'saghen/blink.cmp',
	version = '*',
	opts = {
		-- https://cmp.saghen.dev/configuration/keymap#enter
		keymap = { preset = 'enter', ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' }, },
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono'
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		completion = {
			menu = { auto_show = false, border = 'rounded' },
			documentation = { auto_show = true, auto_show_delay_ms = 50, window = { border = 'rounded' } },
			list = { selection = { preselect = false, auto_insert = false } },
		},
		signature = { window = { border = 'rounded' }, enabled = true },
		snippets = {
			preset = "luasnip"
		},
	},
	opts_extend = { "sources.default" }
}
