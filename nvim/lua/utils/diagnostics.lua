local M = {}

---@class Config
---@field search_engines {[string]: string}
---@field default_engine string
local default_config = {
    search_engines = {
        google = 'https://www.google.com/search?q=',
        duck_duck_go = 'https://duckduckgo.com/?q=',
        perplexity = "https://www.perplexity.ai/search?q=",
        phind = "https://www.phind.com/search?q=",
    },
    default_engine = "google"
}

---@param config Config
local function setup(config)
    M.config = vim.tbl_extend('keep', default_config
    , config or {})
end

--- Search the first diagnostic on the current line
---@param search_engine string? The search engine to use; Must be one of the configured ones
local function search_diagnostic(search_engine)
    local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
    if vim.tbl_isempty(diagnostics) then
        vim.notify("No diagnostic found under cursor", vim.log.levels.INFO)
        return
    end

    local diagnostic = diagnostics[1]
    local message = diagnostic.message:gsub('[^%w%s]', '')

    -- Clean up message for better search results
    message = message:gsub("E%d+", ""):gsub(":%d+", ""):gsub("^%s+", ""):gsub("%s+$", "")

    -- Get current file type
    local ft = vim.bo.filetype
    local search_engine = M.config.search_engines[search_engine] or M.config.search_engines[M.config.default_engine]

    -- Construct search query with context
    local query = message .. "+" .. ft

    -- Open URL
    local url = search_engine .. vim.fn.escape(query, '/')
    local browser = vim.loop.os_getenv("BROWSER")
    if not browser then
        vim.notify("No $BROWSER set", vim.log.levels.ERROR)
        return
    end

    local success = vim.fn.system({ browser, url })

    if success ~= 0 then
        vim.notify("Failed to open URL", vim.log.levels.ERROR)
    end
end

M.setup = setup
M.search_diagnostic = search_diagnostic

return M
