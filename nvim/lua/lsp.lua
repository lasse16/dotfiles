vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        require("mappings").set_lsp_keymappings()
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method("textDocument/inlayHints") then
            vim.lsp.inlay_hint.enable(true)
        end
    end,
})

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
    "rumdl",
}

for _, server in pairs(server_with_default_setup) do
    vim.lsp.enable(server)
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
    flags = {
        debounce_text_changes = 150,
    },
    filetypes = { "markdown", "quarto" },
    root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
})

require("lspconfig").ruff.setup({
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
