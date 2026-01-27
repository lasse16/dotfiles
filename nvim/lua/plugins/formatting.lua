return {
    "stevearc/conform.nvim",
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            yaml = { "yamlfmt" },
            bash = { "shfmt" },
            css = { "stylelint" },
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
}
