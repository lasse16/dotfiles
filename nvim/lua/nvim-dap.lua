require('mappings').set_debugger_keymappings()

local dap = require('dap')

-- UI
-- dap.defaults.fallback.terminal_win_cmd = 'belowright 15split'

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    elements = {
      { id = "breakpoints", size = 0.1 },
      { id = "watches", size = 0.45 },
      { id = "scopes", size = 0.45 },
    },
    size = 40,
    position = "left",
  },
  tray = {
    elements = { "repl" },
    size = 30,
    position = "right",
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

-- Python
dap.adapters.python = {
   type = 'executable',
   command = '/home/lasse/.local/share/nvim/python_environment/bin/python',
   args = { '-m' , 'debugpy.adapter' }
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    python = function()
      local virtual_env = os.getenv('VIRTUAL_ENV')
      local python_env = '/usr/bin/python3'

      print(virtual_env)
      if virtual_env ~= nil then
        python_env = virtual_env .. 'bin/python'
      end

      return python_env
    end;
  },
}

-- Rust
local codelldb_path='/home/lasse/.local/share/dap/lldb/adapter/codelldb'

dap.adapters.lldb = function(on_adapter)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  local cmd = codelldb_path
  local handle, pid_or_err
  local opts = {
    stdio = {nil, stdout, stderr},
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
    end
  end)
  assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      local port = chunk:match('Listening on port (%d+)')
      if port then
        vim.schedule(function()
          on_adapter({
              type = 'server',
              host = '127.0.0.1',
              port = port
            })
          end)
        else
          vim.schedule(function()
            require("dap.repl").append(chunk)
          end)
        end
      end
    end)
    stderr:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end)
  end

dap.configurations.rust = {
  {
    -- The first three options are required by nvim-dap
    type = 'lldb';
    request = 'launch';
    name = "Launch file";

    -- Options below are for CodeLLDB
    cwd = "${workspaceFolder}";
    program = function()
      local workspaceRoot = require'lspconfig'.rust_analyzer.get_root_dir()
      local workspaceName = vim.fn.fnamemodify(workspaceRoot,':t')

      return vim.fn.input("Path to executable: ", workspaceRoot .. '/target/debug/' .. workspaceName, "file")
    end,
    stopOnEntry = false,
    sourceLanguages = { 'rust'},
      },
}
