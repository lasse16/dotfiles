return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = true, -- disables setting the background color.
            show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
            term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
            default_integrations = false,
            integrations = {
                cmp = true,
                dap = true,
                dap_ui = true,
                gitsigns = {
                    enabled = true,
                    transparent = true,
                },
                treesitter = true,
                -- native_lsp = {
                -- 	enabled = true
                -- },
                telescope = {
                    enabled = true,
                },
                lsp_trouble = true,
            },
            custom_highlights = function(colors)
                local utils = require("catppuccin.utils.colors")
                return {
                    GitSignsStagedAdd = {
                        fg = utils.darken(colors.green, 0.5, colors.base),
                    },
                    GitSignsStagedChange = {
                        fg = utils.darken(colors.yellow, 0.5, colors.base),
                    },
                    GitSignsStagedDelete = {
                        fg = utils.darken(colors.red, 0.5, colors.base),
                    },
                }
            end,
        },
    },
}
