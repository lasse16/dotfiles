vim.cmd([[
	command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
	]])

commands = {}

commands.enable_test_running_commands = function()
	print("Loaded test running COMMAND")
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

return commands
