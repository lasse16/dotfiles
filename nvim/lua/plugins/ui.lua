return {
    { "nvim-lualine/lualine.nvim" },
    { "stevearc/dressing.nvim" },
    { "folke/trouble.nvim", branch = "main" },
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                options = {
                    number = true,
                    relativenumber = true,
                    conceallevel = 0,
                },
            },
            plugins = {
                twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
                gitsigns = { enabled = false }, -- disables git signs
                tmux = { enabled = false }, -- disables the tmux statusline
                -- this will change the font size on alacritty when in zen mode
                -- requires  Alacritty Version 0.10.0 or higher
                -- uses `alacritty msg` subcommand to change font size
                alacritty = {
                    enabled = true,
                    font = "14", -- font size
                },
            },
        },
    },
}
