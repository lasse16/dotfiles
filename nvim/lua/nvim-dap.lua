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

-- Python
dap.adapters.python = {
	type = "executable",
	command = "/home/lasse/.local/share/nvim/python_environment/bin/python",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		python = function()
			local virtual_env = os.getenv("VIRTUAL_ENV")
			local python_env = "/usr/bin/python3"

			if virtual_env ~= nil then
				python_env = virtual_env .. "/bin/python"
			end

			return python_env
		end,
	},
}

-- Rust
local codelldb_path = "/home/lasse/.local/share/dap/lldb/adapter/codelldb"

dap.adapters.lldb = {
	type = "server",
	port = "${port}",
	host = "127.0.0.1",
	executable = {
		command = codelldb_path,
		args = { "--port", "${port}" },
	},
}

dap.configurations.rust = {
	{
		-- The first three options are required by nvim-dap
		type = "lldb",
		request = "launch",
		name = "Launch file",

		-- Options below are for CodeLLDB
		cwd = "${workspaceFolder}",
		program = function()
			local workspaceRoot = require("lspconfig").rust_analyzer.get_root_dir()
			local workspaceName = vim.fn.fnamemodify(workspaceRoot, ":t")

			return vim.fn.input("Path to executable: ", workspaceRoot .. "/target/debug/" .. workspaceName, "file")
		end,
		stopOnEntry = false,
		sourceLanguages = { "rust" },
	},
}
