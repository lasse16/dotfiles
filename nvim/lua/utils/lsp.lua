local M = {}

---@class Config
---@field rename_win_style string
local default_config = {
    rename_win_style = "lsp_rename",
}

---@param config Config?
local function setup(config)
    M.config = vim.tbl_extend("keep", default_config, config or {})
end

local function rename()
    local ok, snacks = pcall(require, "snacks")

    local current_name = vim.fn.expand("<cword>")
    if ok and snacks.input then
        snacks.input.input({
            prompt = "rename",
            default = current_name,
            win = {
                style = M.config.rename_win_style,
            },
        }, function(value)
            if value and value ~= "" and value ~= current_name then
                vim.lsp.buf.rename(value)
            end
        end)
    else
        vim.lsp.buf.rename()
    end
end

local yamlls = {
    get_current_schemas = function()
        local current_buf_nr = vim.api.nvim_get_current_buf()
        local client = vim.lsp.get_clients({ bufnr = current_buf_nr, name = "yamlls" })[1]
        if not client then
            vim.notify("No attached YAMLLS found", vim.log.levels.ERROR)
            return
        end
        local document_uri = vim.uri_from_bufnr(vim.api.nvim_get_current_buf())
        vim.notify(string.format("Requesting schema for %s", document_uri), vim.log.levels.INFO)
        local response = client:request_sync("yaml/get/jsonSchema", { document_uri }, nil, current_buf_nr)

        if not response then
            vim.notify("YAMLLS request failed", vim.log.levels.ERROR)
            return
        end

        if response and response.err then
            vim.notify(string.format("YAMLLS returned error: %s", response.err.message), vim.log.levels.ERROR)
            return
        end

        return response.result
    end,
    insert_yamlls_modeline = function()
        local schema = require("schema-companion.context").get_buffer_schema()
        if schema and schema.uri then
            local modeline = "# yaml-language-server: $schema=" .. schema.uri
            local lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)

            -- Check if modeline already exists
            if not vim.startswith(lines[1] or "", "# yaml-language-server:") then
                vim.api.nvim_buf_set_lines(0, 0, 0, false, { modeline })
            end
        end
    end,
}

M.setup = setup
M.rename = rename
M.yamlls = yamlls
return M
