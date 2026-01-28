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
local servers_to_enable = {
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
    "harper_ls",
    "nixd",
    "ltex",
    "marksman",
    "ruff",
    "basedpyright",
}

for _, server in pairs(servers_to_enable) do
    vim.lsp.enable(server)
end

vim.lsp.config("harper_ls", {
    settings = {
        ["harper-ls"] = {
            fileDictPath = vim.fn.getcwd() .. "dict.txt",
        },
    },
    filetypes = { "quarto" },
})

vim.lsp.config("nixd", {
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
vim.lsp.config("ltex", {
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

vim.lsp.config("marksman", {
    flags = {
        debounce_text_changes = 150,
    },
    filetypes = { "markdown", "quarto" },
    root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
})

vim.lsp.config("ruff", {
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

vim.lsp.config("basedpyright", {
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
