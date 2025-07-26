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

M.setup = setup
M.rename = rename
return M
