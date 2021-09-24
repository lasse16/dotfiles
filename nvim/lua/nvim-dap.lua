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
