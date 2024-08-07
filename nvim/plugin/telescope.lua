local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},

		bibtex = {
			context = true, -- parse file for bibliography: field
		}
	}
})
require("mappings").setup_telescope_mappings()
require("commands").enable_telescope_commands()

telescope.load_extension('fzf')
telescope.load_extension("bibtex")
telescope.load_extension("luasnip")
telescope.load_extension("lazy")
