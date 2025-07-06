return {
    -- core neovim features
    { "neovim/nvim-lspconfig", tag = "v1.0.0" },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        },
    },
    {
        "mfussenegger/nvim-dap",
        version = "0.7.0",
        dependencies = { { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } } },
    },
    {
        "L3MON4D3/LuaSnip",
        version = "2.2.0",
        dependencies = "lasse16/friendly-snippets",
    },
    {
        "nvimtools/none-ls.nvim",
        branch = "main",
        dependencies = { "nvim-lua/plenary.nvim", "gbprod/none-ls-shellcheck.nvim" },
    },
    -- git
    { "lewis6991/gitsigns.nvim" },
    { "tpope/vim-fugitive" },
    -- development
    { "mrcjkb/rustaceanvim", version = "^4", lazy = false },
    {
        "quarto-dev/quarto-nvim",
        tag = "v0.18.2",
        ft = "quarto",
        dependencies = { "jmbuhr/otter.nvim" },
    },
    { "folke/lazydev.nvim" },
    -- additional features
    { "junegunn/vim-easy-align" },
    { "tpope/vim-surround" },
    { "wellle/targets.vim" },
    { "windwp/nvim-autopairs" },
    -- tools
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-bibtex.nvim",
            "benfowler/telescope-luasnip.nvim",
            "tsakirist/telescope-lazy.nvim",
        },
    },
    { "FeiyouG/commander.nvim", dependencies = { "nvim-telescope/telescope.nvim" }, tag = "v0.2.0" },
    { "NvChad/nvim-colorizer.lua" },
    -- improvements on builtins
    { "numToStr/Navigator.nvim" },
    { "rhysd/clever-f.vim" },
    { "mrjones2014/smart-splits.nvim" },
    { "mfussenegger/nvim-dap-python" },
}
