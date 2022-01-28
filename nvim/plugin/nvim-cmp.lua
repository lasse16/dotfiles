local cmp = require("cmp")
local compare = require("cmp.config.compare")
local types = require("cmp.types")

local WIDE_HEIGHT = 40

cmp.setup({
	completion = {
		autocomplete = {
			false,
		},
		completeopt = "menu,noselect,noinsert",
	},

	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},

	preselect = types.cmp.PreselectMode.Item,

	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		winhighlight = "NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
	},

	confirmation = {
		default_behavior = types.cmp.ConfirmBehavior.Insert,
		get_commit_characters = function(commit_characters)
			return commit_characters
		end,
	},

	formatting = {
		deprecated = true,
		format = function(_, vim_item)
			return vim_item
		end,
	},

	experimental = {
		ghost_text = false,
	},

	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "ultisnips" },
		{ name = "buffer" },
		{ name = "omni" },
	},
})
