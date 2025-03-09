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
	pickers = {
		help_tags = {
			mappings = {
				i = {
					["<CR>"] = function(prompt_bufnr)
						local selection = require("telescope.actions.state").get_selected_entry()
						require("telescope.actions").close(prompt_bufnr)
						if selection then
							require('windows').help_window:show()
							vim.api.nvim_command("help " .. selection.value)
						end
					end
				}
			}
		}
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
