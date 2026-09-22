return {
    {
        "nvimtools/none-ls.nvim",
        branch = "main",
        dependencies = { "nvim-lua/plenary.nvim", "gbprod/none-ls-shellcheck.nvim" },
        config = function()
            local builtins = require("null-ls").builtins
            require("null-ls").setup({
                sources = {
                    builtins.diagnostics.actionlint,
                    builtins.diagnostics.yamllint,
                    builtins.diagnostics.stylelint,
                    builtins.code_actions.gitsigns,
                    builtins.code_actions.refactoring,
                    require("none-ls-shellcheck.diagnostics"),
                    require("none-ls-shellcheck.code_actions"),
                },
                update_in_insert = false,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        ---@module 'conform'
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                yaml = { "yamlfmt", "injected" },
                json = { "jq" },
                bash = { "shfmt" },
                css = { "stylelint" },
                markdown = { "rumdl", "mdslw", "injected" },
            },
            formatters = {
                mdslw = {
                    -- Anchor config discovery at the real file path;
                    -- otherwise mdslw searches upward from nvim's cwd in stdin mode
                    args = { "--stdin-filepath", "$FILENAME" },
                },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
            format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return nil
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end,
            log_level = vim.log.levels.ERROR,
        },
    },
}
