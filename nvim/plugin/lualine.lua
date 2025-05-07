require("lualine").setup({
    options = { theme = "onedark" },
    sections = {
        lualine_c = { "filename",
            {
                function()
                    local schema = require("schema-companion.context").get_buffer_schema()
                    return ("%s"):format(schema)
                end,
                cond = function()
                    return package.loaded["schema-companion"] ~= nil
                end,
            },
        },
    },
})
