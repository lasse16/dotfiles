---@class Command
---@field name string  Name of the new user command. Must begin with an uppercase letter.
---@field cmd fun(args: vim.api.keyset.create_user_command.command_args?) Replacement command to execute when this user command is executed
---@field opts? vim.api.keyset.user_command Optional command flags

commands = {}

---- utils -----

---@param commands Command[]
--- Register commands as UserCommands *|user-commands|*
local function register_commands(commands)
    for _, command in ipairs(commands) do
        vim.api.nvim_create_user_command(command.name, command.cmd, command.opts or {})
    end
end

-----------------

---@type Command[]
commands.default_vim_commands = {
    {
        name = "DiffOrig",
        cmd = function()
            vim.cmd([[ vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis ]])
        end,
        opts = {
            desc = "Diff to original file",
        },
    },
    {
        name = "WriteSelection",
        cmd = function()
            vim.ui.input({ prompt = "File: " }, function(input)
                if input ~= nil and input ~= "" then
                    vim.cmd(":'<,'> w " .. input)
                    vim.cmd(":norm gvd")
                    vim.cmd(":norm i " .. input)
                end
            end)
        end,
        opts = {
            desc = "Move selection to different file",
        },
        keys = { "v", "<C-r>m" },
    },
    {
        name = "RepoLookUp",
        cmd = function()
            local current_word = vim.fn.expand("<cWORD>"):gsub("[^%w_/.-]", "")
            vim.notify(string.format("Looking for `%s` on Github ", current_word), "info")
            vim.fn.system("gh repo view --web " .. current_word)
        end,
        opts = { desc = "Look for repo on github" },
        keys = { "n", "gG" },
    },
    {
        name = "WebSearch",
        cmd = function()
            require("utils.diagnostics").setup()
            require("utils.diagnostics").search_diagnostic()
        end,
        opts = { desc = "Web search the diagnostic" },
    },
}

commands.enable_test_running_commands = function()
    vim.cmd([[
	command RunTest lua require("neotest").run.run()
	command RunTestFile lua require("neotest").run.run(vim.fn.expand("%"))
	command RunLastTest lua require("neotest").run.run_last()
	command DebugTest lua require("neotest").run.run({strategy = "dap"})
	command StopTest lua require("neotest").run.stop()
	command ToggleTestSummary lua require("neotest").summary.toggle()
	command JumpBackFailedTest lua require("neotest").jump.prev({ status = "failed" })
	command JumpNextFailedTest lua require("neotest").jump.next({ status = "failed" })
	command OpenTest lua require("neotest").output.open({ enter = true })
	]])
end

commands.enable_telescope_commands = function()
    vim.cmd([[
	command Help lua require("telescope.builtin").help_tags()
	command! Man lua require("telescope.builtin").man_pages()
	]])
end

local function insert_yamlls_modeline()
    local schema = require("schema-companion.context").get_buffer_schema()
    if schema and schema.uri then
        local modeline = "# yaml-language-server: $schema=" .. schema.uri
        local lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)

        -- Check if modeline already exists
        if not vim.startswith(lines[1] or "", "# yaml-language-server:") then
            vim.api.nvim_buf_set_lines(0, 0, 0, false, { modeline })
        end
    end
end

commands.yaml = {
    {
        desc = "Insert a modeline specifying the detected schema for YAMLLS",
        cmd = function()
            insert_yamlls_modeline()
        end,
    },
    {
        desc = "Get current schemas for buffer",
        cmd = function()
            local schemas = vim.print(require("utils.lsp").yamlls.get_current_schemas())
            local message = nil
            for _, schema in pairs(schemas) do
                message = message .. schema.name
            end

            if not message then
                message = "No schema assigned"
            end

            vim.notify(message, vim.log.levels.INFO)
        end,
    },
}

---@type Command[]
commands.snacks = {
    {
        name = "ToggleIndentGuides",
        opts = { desc = "Toggle indent guides" },
        cmd = function()
            local Snacks = require("snacks.indent")
            if Snacks.enabled then
                Snacks.disable()
            else
                Snacks.enable()
            end
        end,
    },
}

---@type Command[]
commands.formatting = {
    {
        name = "Format",
        cmd = function(args)
            local range = nil
            if args and args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            require("conform").format({ async = true, range = range })
        end,
        opts = {
            desc = "Format the current buffer",
            range = true,
        },
    },
    {
        name = "FormatDisable",
        cmd = function(args)
            if args and args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end,
        opts = {
            desc = "Disable auto-formatting",
            bang = true,
        },
    },
    {
        name = "FormatEnable",
        cmd = function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end,
        opts = {
            desc = "Enable auto-formatting",
        },
    },
}

register_commands(commands.default_vim_commands)
register_commands(commands.formatting)

return commands
