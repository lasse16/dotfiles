require("lualine").setup({
    options = { theme = "onedark" },
    sections = {
        lualine_c = { "filename",
            {
                function()
                    local schema = require("schema-companion.context").get_buffer_schema()
                    return ("Schema: %s"):format(schema.name)
                end,
                cond = function()
                    return package.loaded["schema-companion"] ~= nil
                end,
            },
        },
    },
})
