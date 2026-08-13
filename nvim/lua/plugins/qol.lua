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
            picker = {
                enabled = true,
                ui_select = true,
            },
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
    {
        "chrisgrieser/nvim-rulebook",
        ---@module 'rulebook'
        ---@type Rulebook.Config
        opts = {},
    },
    {
        "numToStr/Navigator.nvim",
        config = function()
            require("Navigator").setup()
            require("mappings").setup_navigator_keybindings()
        end,
    },
    {
        "FeiyouG/commander.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        tag = "v0.2.0",
        config = function()
            local map = require("utils.map").map
            local commands = require("commands")
            local commander = require("commander")

            local function convert(command)
                return {
                    cmd = command.cmd,
                    desc = command.opts and command.opts.desc or nil,
                    keys = command.keys or nil,
                }
            end

            local function convert_add(commands_to_add)
                commander.add(map(commands_to_add, convert))
            end

            commander.setup({
                prompt_title = "Commands",
                components = {
                    "DESC",
                    "KEYS",
                    "CAT",
                },
                sort_by = {
                    "DESC",
                    "KEYS",
                    "CAT",
                    "CMD",
                },
                integration = {
                    telescope = {
                        enable = true,
                    },
                    lazy = {
                        enable = true,
                        set_plugin_name_as_cat = true,
                    },
                },
            })

            commander.add({
                {
                    desc = "Open command palette",
                    cmd = require("commander").show,
                    keys = { "n", "<C-Space>" },
                },
            })

            convert_add(commands.default_vim_commands)
            convert_add(commands.snacks)
            convert_add(commands.formatting)
        end,
    },
}
