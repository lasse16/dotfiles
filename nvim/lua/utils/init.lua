local M = {}

M.diagnostics = require("utils.diagnostics")
M.websearch = require("utils.websearch")
M.lsp = require("utils.lsp")
M.map = require("utils.map")
M.treesitter = require("utils.treesitter")

M.diagnostics.setup()
M.websearch.setup()
M.lsp.setup()

return M
