local M = {}
local websearch = nil

---@param config Config?
local function setup(config)
	websearch = require("utils.websearch")
	websearch.setup(config)
end

--- Search the first diagnostic on the current line
---@param search_engine string? The search engine to use; Must be one of the configured ones
local function search_diagnostic(search_engine)
	if not websearch then
		error("Module not initialized")
	end

	local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
	if vim.tbl_isempty(diagnostics) then
		vim.notify("No diagnostic found under cursor", vim.log.levels.INFO)
		return
	end

	local diagnostic = diagnostics[1]
	local message = diagnostic.message:gsub("[^%w%s]", "")

	-- Clean up message for better search results
	message = message:gsub("E%d+", ""):gsub(":%d+", ""):gsub("^%s+", ""):gsub("%s+$", "")

	-- Get current file type
	local ft = vim.bo.filetype

	-- Construct search query with context
	local query = message .. "+" .. ft

	websearch.search(query, search_engine)
end

M.setup = setup
M.search_diagnostic = search_diagnostic

return M
