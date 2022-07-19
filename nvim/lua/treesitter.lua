require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
-- Add non-standard parser
require("nvim-treesitter.parsers").get_parser_configs().just = {
	install_info = {
		url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
		files = { "src/parser.c", "src/scanner.cc" },
		branch = "main",
	},
	maintainers = { "@IndianBoy42" },
}
print("Treesitter setup finished")
