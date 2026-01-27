---Convert a UserCommand to a CommanderItem
---@param command Command
---@return CommanderItem
local function convert(command)
    local converted_command = {
        cmd = command.cmd,
        desc = command.opts.desc or nil,
    }
    return converted_command
end

require("commander").setup({
    prompt_title = "Commands",
    components = {
        "DESC",
        "KEYS",
        "CAT",
    },
    sort_by = {
        "DESC",
        "KEYS",
        "CAT",
        "CMD",
    },
    integration = {
        telescope = {
            enable = true,
        },
        lazy = {
            enable = true,
            set_plugin_name_as_cat = true,
        },
    },
})

require("commander").add({
    {
        desc = "Open command palette",
        cmd = require("commander").show,
        keys = { "n", "<C-o>" },
    },
})

local commands = require("commands").default_vim_commands
local snacks_commands = require("commands").snacks
require("commander").add(commands)
require("commander").add(snacks_commands)
require("commander").add(require("utils.map").map(require("commands").formatting, convert))
