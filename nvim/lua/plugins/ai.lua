return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        opts = {
            debug = true,
        },
        config = function(_, opts)
            require("CopilotChat").setup(opts)
            require("mappings").setup_copilot_chat_mappings()
        end,
    },
}
