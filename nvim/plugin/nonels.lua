local builtins = require("null-ls").builtins
require("null-ls").setup({
    sources = {
        builtins.diagnostics.actionlint,
        builtins.diagnostics.yamllint.with({
            extra_args = { "-d", "{extends: default, rules: {line-length: {max: 120}}}" },
        }),
        builtins.diagnostics.stylelint,
        builtins.code_actions.gitsigns,
        builtins.code_actions.refactoring,
        builtins.formatting.yamlfmt,
        builtins.formatting.stylelint,
        builtins.formatting.shfmt,
        builtins.formatting.stylua,
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
    },
    update_in_insert = false,
})
