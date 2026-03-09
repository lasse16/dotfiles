M = {}
local markdown = {

    ---@param bufnr integer
    ---@return string? error # Error message if applicable
    move_reference_links_to_file_end = function(bufnr)
        if not bufnr then
            bufnr = vim.api.nvim_get_current_buf()
        end

        local reference_link_query = [[
        ;query
        (link_reference_definition) @def
        ]]

        local parser, error = vim.treesitter.get_parser(bufnr, "markdown", { error = false })
        if parser == nil then
            return error
        end
        local tree = parser:parse()[1]
        local root = tree:root()

        local query = vim.treesitter.query.parse("markdown", reference_link_query)

        for id, node, metadata in query:iter_captures(tree:root(), 0) do
            local text = vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf())
            local start_row, start_col, end_row, end_col = node:range()

            -- Delete node text
            vim.api.nvim_buf_set_lines(bufnr, start_row, end_row, false, {})

            local last_line = vim.api.nvim_buf_line_count(bufnr)
            vim.api.nvim_buf_set_lines(bufnr, last_line, last_line, false, { text })
            vim.notify("moved " .. text)
        end
    end,
}

M.markdown = markdown
return M
