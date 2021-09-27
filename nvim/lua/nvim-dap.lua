require('mappings').set_debugger_keymappings()

local dap = require('dap')

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
local codelldb_port=4000
local codelldb_path='/home/lasse/.local/share/dap/lldb/adapter/codelldb'

dap.adapters.lldb = function(callback, config)
  -- NOT WORKING TODO was an attempt to start the server upon launching the debugee
  -- os.execute(codelldb_path .. '--port ' .. config.port)
  callback({ type = "server", host= '127.0.0.1', port = config.port })
end

dap.configurations.rust = {
  {
    -- The first three options are required by nvim-dap
    type = 'lldb';
    request = 'launch';
    name = "Launch file";

    -- Options below are for CodeLLDB
    cwd = "${workspaceFolder}";
    port = codelldb_port,
    program = function()
      local current_working_dir = vim.fn.getcwd()
      local cwd_parent = vim.fn.fnamemodify(current_working_dir,':p:h:h')
      local cwd_parent_name = vim.fn.fnamemodify(cwd_parent,':t')

      return vim.fn.input("Path to executable: ", cwd_parent .. '/target/debug/' .. cwd_parent_name, "file")
    end,
    stopOnEntry = false,
    args = {},
      },
}
