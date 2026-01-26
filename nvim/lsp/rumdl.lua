---@type vim.lsp.Config
return {
    cmd = { "rumdl", "server" },

    filetypes = { "markdown" },
    root_markers = { { ".rumdl.toml", "rumdl.toml" }, ".git" },

    settings = {
        rumdl = {
            line_length = 120,
        },
    },
}
