vim.cmd([[
	command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
	]])

commands = {}

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
