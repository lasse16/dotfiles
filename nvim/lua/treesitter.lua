require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
                ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
                ["ac"] = { query = "@class.outer", desc = "Select outer part of a function" },
                ["ic"] = {
                    query = "@class.inner",
                    desc = "Select inner part of a class region",
                },
            },
            include_surrounding_whitespace = true,
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
})
