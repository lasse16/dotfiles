local M = {}

M.diagnostics = require("utils.diagnostics")
M.websearch = require("utils.websearch")
M.lsp = require("utils.lsp")

M.diagnostics.setup()
M.websearch.setup()
M.lsp.setup()

return M
