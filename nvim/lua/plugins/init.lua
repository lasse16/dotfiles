return {
	-- core neovim features
	{ "neovim/nvim-lspconfig", tag = "v0.1.7" },
	{
		"nvim-treesitter/nvim-treesitter",
		version = "0.9.2",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	{ "mfussenegger/nvim-dap", version = "0.7.0",  dependencies = { { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } } } },
	{
		"hrsh7th/nvim-cmp",
		branch = "main",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp",        branch = "main" },
			{ "hrsh7th/cmp-buffer",          branch = "main" },
			{ "saadparwaiz1/cmp_luasnip",    dependencies = "L3MON4D3/LuaSnip" },
			{ "rcarriga/cmp-dap" },
			{ "jmbuhr/cmp-pandoc-references" },
			{ "kdheepak/cmp-latex-symbols" },
			{ 'hrsh7th/cmp-cmdline' }
		},
	},
	{ "L3MON4D3/LuaSnip",              version = "2.2.0",                                                                            dependencies = "lasse16/friendly-snippets" },
	{ "nvimtools/none-ls.nvim",        branch = "main",                                                                              dependencies = "nvim-lua/plenary.nvim" },
	-- git
	{ "lewis6991/gitsigns.nvim" },
	{ "tpope/vim-fugitive" },
	-- UI
	{ "nvim-lualine/lualine.nvim" },
	{ "stevearc/dressing.nvim" },
	{ "folke/trouble.nvim",            branch = "main" },
	-- development
	{ "simrat39/rust-tools.nvim",      dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap", "nvim-lua/plenary.nvim" }, },
	{ 'quarto-dev/quarto-nvim',        tag = 'v0.18.2',                                                                              ft = "quarto",                                                                                                                                                                         dependencies = { 'jmbuhr/otter.nvim' } },
	{ "folke/neodev.nvim" },
	-- additional features
	{ "junegunn/vim-easy-align" },
	{ "numToStr/Comment.nvim" },
	{ "tpope/vim-surround" },
	{ "wellle/targets.vim" },
	{ "windwp/nvim-autopairs" },
	-- tools
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.5',                                                                                dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, "nvim-telescope/telescope-bibtex.nvim", "benfowler/telescope-luasnip.nvim" } },
	{ "FeiyouG/commander.nvim",        dependencies = { "nvim-telescope/telescope.nvim" },                                           tag = "v0.2.0" },
	{ "NvChad/nvim-colorizer.lua" },
	-- improvements on builtins
	{ "numToStr/Navigator.nvim" },
	{ "rhysd/clever-f.vim" },
	{ "mrjones2014/smart-splits.nvim" },
}
