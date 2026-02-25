vim.diagnostic.config({
    virtual_text = {
        prefix = "● ",
        suffix = function(diagnostic)
            return require("rulebook").hasDocs(diagnostic) and " ↗" or ""
        end,
    },
    float = { border = "rounded" },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
