local builtins = require("null-ls").builtins
require("null-ls").setup({
    sources = {
        builtins.diagnostics.actionlint,
        builtins.diagnostics.yamllint.with({
            extra_args = {
                "-d",
                "{extends: default, rules: {line-length: {max: 120}, document-start: disable, truthy: disable}}",
            },
        }),
        builtins.diagnostics.stylelint,
        builtins.code_actions.gitsigns,
        builtins.code_actions.refactoring,
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
    },
    update_in_insert = false,
})
