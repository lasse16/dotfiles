local M = {}

---@class Config
---@field search_engines {[string]: string}
---@field default_engine string
local default_config = {
    search_engines = {
        google = "https://www.google.com/search?q=",
        duck_duck_go = "https://duckduckgo.com/?q=",
        perplexity = "https://www.perplexity.ai/search?q=",
        phind = "https://www.phind.com/search?q=",
    },
    default_engine = "google",
}

---@param config Config?
local function setup(config)
    M.config = vim.tbl_extend("keep", default_config, config or {})
end

local function search(query, search_engine)
    local search_engine = M.config.search_engines[search_engine] or M.config.search_engines[M.config.default_engine]

    -- Open URL
    local url           = search_engine .. vim.fn.escape(query, "/")
    local browser       = vim.loop.os_getenv("BROWSER")
    if not browser then
        vim.notify("No $BROWSER set", vim.log.levels.ERROR)
        return
    end

    vim.system({ browser, url }, nil, function(completed)
        if completed.code ~= 0 then
            vim.notify("Failed to open URL", vim.log.levels.ERROR)
        end
    end)
end

local function search_without_query(search_engine)
    vim.ui.input({ prompt = "Search?" }, function(input)
        if input then
            local escaped_query = vim.uri_encode(input)

            search(escaped_query, search_engine)
        end
    end)
end

M.setup = setup
M.search = search
return M
