local map = require("utils.map").map
local commands = require("commands")
local commander = require("commander")

---Convert a UserCommand to a CommanderItem
---@param command Command
---@return CommanderItem
local function convert(command)
    local desc = nil
    if command.opts and command.opts.desc then
        desc = command.opts.desc or nil
    end
    local converted_command = {
        cmd = command.cmd,
        desc = desc,
        keys = command.keys or nil,
    }
    return converted_command
end

---Convert UserCommands to CommanderItems and add them to Commander
---@param commands_to_add Command[] Commands to be added
function convert_add(commands_to_add)
    commander.add(map(commands_to_add, convert))
end

------------------------------------------

commander.setup({
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

commander.add({
    {
        desc = "Open command palette",
        cmd = require("commander").show,
        keys = { "n", "<C-o>" },
    },
})

convert_add(commands.default_vim_commands)
convert_add(commands.snacks)
convert_add(commands.formatting)
