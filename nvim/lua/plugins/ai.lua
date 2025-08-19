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

            -- disable ui stuff
            highlight_headers = false,
            separator = "---",
            error_header = "> [!ERROR] Error",
        },
        config = function(_, opts)
            require("CopilotChat").setup(opts)
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                callback = function()
                    vim.opt_local.relativenumber = false
                    vim.opt_local.number = false
                    vim.opt_local.conceallevel = 0
                end,
            })
            require("mappings").setup_copilot_chat_mappings()
        end,
    },
}
