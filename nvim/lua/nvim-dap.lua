require("mappings").set_debugger_keymappings()

local dap = require("dap")
local dapui = require("dapui")

-- UI
dap.defaults.fallback.terminal_win_cmd = "below 10new"

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
    },
    layouts = {
        {
            elements = {
                "watches",
                "scopes",
                "breakpoints",
            },
            size = 50,
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 10,
            position = "bottom",
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
})

-- Open UI automatically when Debug Session is created

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end

vim.cmd([[
	command! DebugUIClose lua require'dapui'.close()
	command! DebugUIOpen lua require'dapui'.open()
	command! DebugUIToggle lua require'dapui'.toggle()
	]])

require("dap-python").setup("python3")
