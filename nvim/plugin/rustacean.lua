local config = require("lsp")

local rust_analyzer_opts = {
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    flags = {
        debounce_text_changes = 200,
    },
    default_settings = {
        ["rust-analyzer"] = {
            procMacro = {
                enable = false,
            },
            checkOnSave = {
                command = "clippy",
            },
            -- https://github.com/rust-lang/rust-analyzer/issues/20051
            cargo = {
                extraEnv = { RUSTUP_TOOLCHAIN = "stable" },
            },
        },
    },
}

vim.g.rustaceanvim = {
    server = rust_analyzer_opts,
}
