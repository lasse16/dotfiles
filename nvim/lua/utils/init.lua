local M = {}

M.diagnostics = require('utils.diagnostics')
M.websearch = require('utils.websearch')

M.diagnostics.setup()
M.websearch.setup()

return M
