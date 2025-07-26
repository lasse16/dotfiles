return {
    {
        ---@module 'snacks'
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            animate = { enabled = false },
            bigfile = { enabled = true },
            dashboard = { enabled = false },
            dim = { enabled = true },
            gitbrowse = { enabled = true },
            indent = { enabled = true },
            input = {
                enabled = true,
                win = {
                    style = "input",
                    border = "rounded",
                },
            },
            lazygit = { enabled = false },
            notifier = { enabled = true },
            picker = { enabled = false },
            profiler = { enabled = false },
            quickfile = { enabled = true },
            scope = { enabled = false },
            scratch = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = false },
            terminal = { enabled = true },
            toggle = { enabled = true },
            win = { enabled = true },
            words = { enabled = false },
            zen = { enabled = true },
            styles = {
                lsp_rename = {
                    backdrop = false,
                    position = "float",
                    border = "rounded",
                    title_pos = "left",
                    height = 1,
                    width = 60,
                    relative = "cursor",
                    noautocmd = true,
                    wo = {
                        winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
                        cursorline = false,
                    },
                    bo = {
                        filetype = "snacks_input",
                        buftype = "prompt",
                    },
                    keys = {
                        n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                        i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
                        i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
                        q = "cancel",
                    },
                },
            },
        },
    },
}
