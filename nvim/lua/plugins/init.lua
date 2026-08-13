return {
    -- core neovim features
    { "neovim/nvim-lspconfig" },
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
        version = "2.4.0",
        dependencies = "lasse16/friendly-snippets",
    },
    {
        "nvimtools/none-ls.nvim",
        branch = "main",
        dependencies = { "nvim-lua/plenary.nvim", "gbprod/none-ls-shellcheck.nvim" },
    },
    -- git
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "┃" },
                change = { text = "┃" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            preview_config = {
                border = "rounded",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            on_attach = require("mappings").setup_gitsigns_mappings,
        },
    },
    { "tpope/vim-fugitive" },
    -- development
    { "mrcjkb/rustaceanvim", version = "^4", lazy = false },

    -- additional features
    { "junegunn/vim-easy-align" },
    { "tpope/vim-surround" },
    { "wellle/targets.vim" },
    { "windwp/nvim-autopairs" },
    -- tools
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-bibtex.nvim",
            "benfowler/telescope-luasnip.nvim",
            "tsakirist/telescope-lazy.nvim",
        },
    },
    { "FeiyouG/commander.nvim", dependencies = { "nvim-telescope/telescope.nvim" }, tag = "v0.2.0" },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            filetypes = { "html", "css", "scss", "yaml", "toml", "markdown" },
            options = { parsers = { css = true } },
        },
    },
    -- improvements on builtins
    { "rhysd/clever-f.vim" },
    { "mrjones2014/smart-splits.nvim" },
    { "mfussenegger/nvim-dap-python" },
}
