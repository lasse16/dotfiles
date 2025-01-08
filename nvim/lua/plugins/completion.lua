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
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		completion = {
			menu = { border = 'rounded' },
			documentation = { window = { border = 'rounded' } },
		},
		signature = { window = { border = 'rounded' }, enabled = true },
	},
	opts_extend = { "sources.default" }
}
