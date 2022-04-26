packer = require("packer").startup({
	function()
		use("wbthomason/packer.nvim")
		use("neovim/nvim-lspconfig")
		use({
			"hrsh7th/nvim-cmp",
			branch = "main",
			requires = {
				{ "hrsh7th/cmp-nvim-lsp", branch = "main" },
				{ "hrsh7th/cmp-buffer", branch = "main" },
				{ "hrsh7th/cmp-path", branch = "main" },
				{ "hrsh7th/cmp-omni", branch = "main" },
				{ "hrsh7th/cmp-nvim-lsp-signature-help", branch = "main" },
				{ "quangnguyen30192/cmp-nvim-ultisnips", branch = "main", requires = "SirVer/ultisnips" },
			},
		})
		use("junegunn/vim-easy-align")
		use("tpope/vim-fugitive")
		use("nvim-lualine/lualine.nvim")
		use("lilydjwg/colorizer")
		use("numToStr/Comment.nvim")
		use("tpope/vim-surround")
		use("wellle/targets.vim")
		use("rhysd/clever-f.vim")
		use("$HOME/src/fzf")
		use({ "junegunn/fzf.vim", requires = "$HOME/src/fzf" })
		use({ "SirVer/ultisnips", requires = "honza/vim-snippets" })
		use("kosayoda/nvim-lightbulb")
		use("nvim-treesitter/nvim-treesitter", { cmd = ":TSUpdate" })
		use({ "mfussenegger/nvim-dap", requires = "rcarriga/nvim-dap-ui" })
		use({
			"simrat39/rust-tools.nvim",
			requires = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap", "nvim-lua/plenary.nvim" },
		})
		use("mizlan/iswap.nvim")
		use({ "soywod/himalaya", rtp = "vim" })
		use({ "jose-elias-alvarez/null-ls.nvim", branch = "main", requires = "nvim-lua/plenary.nvim" })
		use({ "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" })
		use("rcarriga/nvim-notify")
		use({ "folke/trouble.nvim", branch = "main" })
		use("stevearc/dressing.nvim")
	end,
})
-- Load file directly, see https://github.com/wbthomason/packer.nvim/discussions/651
loadfile(packer.config.compile_path)
return packer
