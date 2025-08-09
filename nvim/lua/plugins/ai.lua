return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        ---@module 'CopilotChat'
        ---@type CopilotChat.config.Config
        opts = {
            debug = true,
            model = "claude-sonnet-4",
            window = {
                layout = "vertical",
                width = 0.4,
            },
            temperature = 0.1,
            auto_insert_mode = false,
        },
        config = function(_, opts)
            require("CopilotChat").setup(opts)
            require("mappings").setup_copilot_chat_mappings()
        end,
    },
}
