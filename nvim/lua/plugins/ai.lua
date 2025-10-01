return {
    {
        "sudo-tee/opencode.nvim",
        branch = "main",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        ---@module 'opencode'
        ---@type OpencodeConfig
        opts = {
            preferred_picker = "telescope",
            default_global_keymaps = false,
            default_mode = "plan",
            debug = {
                enabled = true,
            },
            model = "claude-sonnet-4",
            ui = {
                window_width = 0.4,
                icons = {
                    preset = "text",
                },
            },
        },
        config = function(opts)
            require("opencode").setup(opts)
            require("mappings").setup_ai_mappings()
        end,
    },
}
