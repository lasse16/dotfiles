vim.cmd([[
	command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
	]])

commands = {}

commands.default_vim_commands = {
	{
		desc = "Diff to original file",
		cmd = "<CMD>vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis<CR>",
	},
	{
		desc = "Move selection to different file",
		cmd = function()
			vim.ui.input({ prompt = "File: " }, function(input)
				if input ~= nil and input ~= "" then
					vim.cmd(":'<,'> w " .. input)
					vim.cmd(":norm gvd")
					vim.cmd(":norm i " .. input)
				end
			end)
		end,
		keys = { "v", "<C-r>m" },
	},
	{
		desc = "Look for repo on github",
		cmd = function()
			local current_word = vim.fn.expand("<cWORD>"):gsub("[^%w_/-.]", "")
			vim.fn.system("gh repo view --web " .. current_word)
		end,
		keys = { "n", "gG" },
	},
	{
		desc = "Web search the diagnostic",
		cmd = function()
			require("utils.diagnostics").setup()
			require("utils.diagnostics").search_diagnostic()
		end,
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

commands.snacks = {
    {
        desc = "Toggle indent guides",
        cmd = function()
            local Snacks = require("snacks.indent")
            if Snacks.enabled then
                Snacks.disable()
            else
                Snacks.enable()
            end
        end
    }
}

return commands
