local on_attach = function(client, bufnr)
	require("mappings").set_lsp_keymappings()

	vim.diagnostic.config({
		virtual_text = {
			prefix = "◁◁◁◁ ",
		},
        float = { border = "rounded" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true
	})

	-- If LSP-Server can format, format on write
	if client.server_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end

	vim.lsp.inlay_hint.enable(true)
end

-- Setup completion engine
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

config = {
	on_attach = on_attach,
	capabilites = capabilities,
}

-- Setup default config for specified servers
local server_with_default_setup = {
	"pylsp",
	"ansiblels",
	"ts_ls",
	"emmet_ls",
	"kcl",
	"taplo",
	"nil_ls",
	"terraformls",
	"tflint",
	"gopls",
}
for _, lsp in ipairs(server_with_default_setup) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilites = capabilites,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

require("lspconfig").harper_ls.setup({
	settings = {
		["harper-ls"] = {
			fileDictPath = vim.fn.getcwd() .. "dict.txt",
		},
	},
	filetypes = { "quarto" },
})

require("lspconfig").nixd.setup({
	settings = {
		nixd = {
			formatting = {
				command = { "alejandra" },
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
				},
				home_manager = {
					expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
				},
			},
		},
	},
})
require("lspconfig")["ltex"].setup({
	on_attach = on_attach,
	capabilites = capabilites,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		ltex = {
			language = "en-GB",
			additionalRules = {
				languageModel = "~/.share/models/ngrams/",
			},
		},
	},
})

require("lspconfig").marksman.setup({
	on_attach = on_attach,
	capabilites = capabilites,
	flags = {
		debounce_text_changes = 150,
	},
	filetypes = { "markdown", "quarto" },
	root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
})

require("lspconfig").ruff.setup({
	on_attach = on_attach,
	capabilites = capabilites,
	flags = {
		debounce_text_changes = 150,
	},
	trace = "messages",
	init_options = {
		settings = {
			logLevel = "debug",
		},
	},
})

require("lspconfig").basedpyright.setup({
	on_attach = on_attach,
	capabilites = capabilites,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		basedpyright = {
			analysis = {
				logLevel = "Error",
				typeCheckingMode = "standard",
			},
		},
	},
})

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local vscode_lsps = { "cssls", "jsonls", "html" }
for _, lsp in ipairs(vscode_lsps) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

return config
