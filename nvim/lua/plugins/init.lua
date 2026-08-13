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
        dependencies = "rafamadriz/friendly-snippets",
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
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        lazy = false,
        init = function()
            vim.g.rustaceanvim = {
                server = {
                    flags = {
                        debounce_text_changes = 200,
                    },
                    default_settings = {
                        ["rust-analyzer"] = {
                            procMacro = {
                                enable = false,
                            },
                            checkOnSave = {
                                command = "clippy",
                            },
                            -- https://github.com/rust-lang/rust-analyzer/issues/20051
                            cargo = {
                                extraEnv = { RUSTUP_TOOLCHAIN = "stable" },
                            },
                        },
                    },
                },
            }
        end,
    },

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
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        },
                    },
                },
                pickers = {
                    help_tags = {
                        mappings = {
                            i = {
                                ["<CR>"] = function(prompt_bufnr)
                                    local selection = require("telescope.actions.state").get_selected_entry()
                                    require("telescope.actions").close(prompt_bufnr)
                                    if selection and selection.value and selection.value ~= "" then
                                        require("windows").help_window:show()
                                        vim.api.nvim_command("help " .. selection.value)
                                    end
                                end,
                            },
                        },
                    },
                },
                extensions = {
                    bibtex = {
                        context = true,
                    },
                },
            })
            require("mappings").setup_telescope_mappings()
            require("commands").enable_telescope_commands()
            telescope.load_extension("bibtex")
            telescope.load_extension("luasnip")
            telescope.load_extension("lazy")
        end,
    },

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
