local map = require("utils.map").map
local commands = require("commands")
local commander = require("commander")

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

local commands = require("commands").default_vim_commands
commander.add(commands.snacks)
commander.add(map(commands.formatting, convert))
