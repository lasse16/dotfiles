return {
	-- core neovim features
	{ "neovim/nvim-lspconfig", tag = "v1.0.0" },
	{
		"nvim-treesitter/nvim-treesitter",
		version = "0.9.2",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	{ "mfussenegger/nvim-dap", version = "0.7.0", dependencies = { { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } } } },
	{ "L3MON4D3/LuaSnip",              version = "2.2.0",                                  dependencies = "lasse16/friendly-snippets" },
	{ "nvimtools/none-ls.nvim",        branch = "main",                                    dependencies = { "nvim-lua/plenary.nvim", "gbprod/none-ls-shellcheck.nvim" } },
	-- git
	{ "lewis6991/gitsigns.nvim" },
	{ "tpope/vim-fugitive" },
	-- development
	{ 'mrcjkb/rustaceanvim',           version = '^4',                                     lazy = false, },
	{ 'quarto-dev/quarto-nvim',        tag = 'v0.18.2',                                    ft = "quarto",                                                                                                                                                                                                          dependencies = { 'jmbuhr/otter.nvim' } },
	{ "folke/lazydev.nvim" },
	-- additional features
	{ "junegunn/vim-easy-align" },
	{ "tpope/vim-surround" },
	{ "wellle/targets.vim" },
	{ "windwp/nvim-autopairs" },
	-- tools
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.5',                                      dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, "nvim-telescope/telescope-bibtex.nvim", "benfowler/telescope-luasnip.nvim", "tsakirist/telescope-lazy.nvim" } },
	{ "FeiyouG/commander.nvim",        dependencies = { "nvim-telescope/telescope.nvim" }, tag = "v0.2.0" },
	{ "NvChad/nvim-colorizer.lua" },
	-- improvements on builtins
	{ "numToStr/Navigator.nvim" },
	{ "rhysd/clever-f.vim" },
	{ "mrjones2014/smart-splits.nvim" },
	{ "mfussenegger/nvim-dap-python" },
	{
		---@module 'snacks'
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			animate = { enabled = false },
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			dim = { enabled = true },
			gitbrowse = { enabled = true },
			indent = { enabled = true },
			input = { enabled = false },
			lazygit = { enabled = false },
			notifier = { enabled = true },
			profiler = { enabled = false },
			quickfile = { enabled = true },
			scope = { enabled = false },
			scratch = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = false },
			terminal = { enabled = true },
			toggle = { enabled = true },
			win = { enabled = true },
			words = { enabled = false },
			zen = { enabled = true },
			styles = {},
		}
		-- open_repo = require('snacks').gitbrowse.open()
		-- show_notifier_history = require('snacks').notifier.show_history()
		-- hide all notifications = Snacks.notifier.hide(id|"all")
		-- enable/disable dimming = Snacks.dim.disable()/.enable()
		-- rename current file = Snacks.rename.rename_file()
		-- toggle_indent_giudes = Snacks.indent.disable()/enable()
		-- open scratch buffer = Snacks.scratch()
		-- select scrawtch buffer = Snacks.scratch.select()
		-- toggle terminal = Snacks.terminal.toggle(cmd, opts)
	},
}
