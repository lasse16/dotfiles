return {
	"kcl-lang/kcl.nvim",
	{
		"cenk1cenk2/schema-companion.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		ft = "yaml",
		config = function()
			require("schema-companion").setup({
				-- if you have telescope you can register the extension
				enable_telescope = true,
				matchers = {
					require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
				},
			})
			require("mappings").setup_schema_mappings()
			local config = require("lsp")
			require("lspconfig").yamlls.setup(require("schema-companion").setup_client({
				on_attach = config.on_attach,
				capabilites = config.capabilites,
				flags = {
					debounce_text_changes = 150,
				},
				settings = {
					yaml = {
						format = {
							enable = true,
						},
						validate = {
							enable = true,
						},
						completion = {
							enable = true,
						},
						hover = {
							enable = true,
						},
						schemaStore = {
							enable = true,
						},
					},
				},
			}))
		end,
	},
}
