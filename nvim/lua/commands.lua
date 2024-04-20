vim.cmd([[
	command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
	]])

commands = {}

commands.default_vim_commands = {
	{
		desc = "Diff to original file",
		cmd = "<CMD>vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis<CR>"
	},
	{
		desc = "Move selection to different file",
		cmd = function()
			vim.ui.input({ prompt = 'File: ' }, function(input)
				if input ~= nil and input ~= '' then
					vim.cmd(":'<,'> w " .. input)
					vim.cmd(":norm gvd")
					vim.cmd(":norm i " .. input)
				end
			end)
		end,
		keys = { "v", "<C-r>m" }
	},
	{
		desc = "Look for repo on github",
		cmd = function()
			local current_word = vim.fn.expand('<cWORD>'):gsub("[^%w_/-.]", '')
			vim.fn.system('gh repo view --web ' .. current_word)
		end,
		keys = { "n", 'gG' }
	}
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

return commands
