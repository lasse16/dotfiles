local iron = require("iron")
vim.g.iron_map_defaults = 0
vim.g.iron_map_extended = 0

vim.cmd([[
	command! -range SendToREPLVisual '<,'> lua require'iron'.core.visual_send()
	command SendToREPLLine lua require'iron'.core.send_line()
	command SendToREPLRepeatLast lua require'iron'.core.repeat_cmd()
	]])
