M = {}

-- utils
local function map_key(...)
    vim.keymap.set(...)
end

local function unmap_key(mode, key)
    vim.keymap.set(mode, key, "<Nop>", {})
end

local silent = { silent = true }
local silent_buffer = { buffer = true, silent = true }

local function make_extendable(base_table)
    return setmetatable(base_table, {
        __concat = function(t, other)
            if type(other) == "table" then
                -- Merge tables using vim.tbl_extend
                return vim.tbl_extend("force", t, other)
            else
                error("Unsupported type for concatenation")
            end
        end,
    })
end

silent = make_extendable(silent)
silent_buffer = make_extendable(silent_buffer)

local function add_mappings_from_table(mappings)
    for _, opts in pairs(mappings) do
        map_key(unpack(opts))
    end
end

------------------------------------------------------

M.setup = function(mappings)
    add_mappings_from_table(mappings)
end

local global_mappings = {
    -- Move lines up and down
    { "n", "<A-j>", ":m .+1<CR>==" },
    { "n", "<A-k>", ":m .-2<CR>==" },
    { "v", "<A-k>", ":m '<-2<CR>gv=gv" },
    { "v", "<A-j>", ":m '>+1<CR>gv=gv" },

    -- Map <Ctrl-S> to saving the current open document
    { "n", "<C-s>", "<ESC>:update<CR>" },

    -- Unbind some useless/annoying default key bindings.
    { "n", "Q", "<Nop>", {} }, -- 'Q' in normal mode enters Ex mode. You almost never want this.

    -- Close terminal mode with <Esc>
    -- stylua: ignore start
    { "t", "<Esc>",          [[<C-\><C-n>]] },
    { "t", "<C-w>",          [[<C-\><C-n><C-w>]] },
    -- stylua: ignore end

    -- Remove highlighting
    { "n", "<Esc>", "<cmd>nohlsearch<CR>" },

    -- make ZW behave like ZZ and ZQ
    { "n", "ZW", "<ESC>:update<CR>" },

    -- diagnostics
    { "n", "<space>d", vim.diagnostic.open_float, silent_buffer },
    { "n", "<space>dp", vim.diagnostic.goto_prev, silent_buffer },
    { "n", "<space>dn", vim.diagnostic.goto_next, silent_buffer },
    { "n", "<space>dl", vim.diagnostic.setloclist, silent_buffer },
    {
        "n",
        "<space>ds",
        function()
            require("utils.diagnostics").search_diagnostic()
        end,
        silent_buffer .. { desc = "Web search the diagnostic on the current line" },
    },
    {
        "n",
        "<space>s",
        function()
            require("utils").websearch.search_query()
        end,
        silent_buffer .. { desc = "Web search a query" },
    },

    -- 60% keyboard adjust
    {
        "c",
        "<c-j>",
        "<Down>",
        { desc = "Select next command in Command mode history" },
    },
    {
        "c",
        "<C-k>",
        "<Up>",
        { desc = "Select previous command in Command mode history" },
    },

    {
        "s",
        "<C-p>",
        '<C-o>"+p',
        { desc = "Paste system clipboard in select mode" },
    },

    {
        "n",
        "+",
        "<C-a>",
        { desc = "Increment number" },
    },
    {
        "n",
        "-",
        "<C-x>",
        { desc = "Decrement number" },
    },

    {
        "n",
        "<C-a>",
        "gg<S-v>G",
        { desc = "Select entire buffer" },
    },
    {
        "n",
        "<space><space>",
        "<cmd>b#<CR>",
        { desc = "Jump back to previous buffer" },
    },

    {
        "v",
        "<",
        "<gv",
        { desc = "Keep selection after indenting" },
    },
    {
        "v",
        ">",
        ">gv",
        { desc = "Keep selection after indenting" },
    },

    {
        "n",
        "<space>fn",
        "<cmd>enew<CR>",
        { desc = "Create new file" },
    },
    {
        "v",
        "<space>fn",
        function()
            local start_pos = vim.fn.getpos("'<")
            local end_pos = vim.fn.getpos("'>")

            local text =
                vim.api.nvim_buf_get_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3] - 1, {})

            local buf_id = vim.api.nvim_create_buf(true, false)

            vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, text)
            vim.api.nvim_win_set_buf(0, buf_id)
            return buf_id
        end,
        { desc = "Create a new file from visual selection" },
    },

    {
        "n",
        "<space>fw",
        function()
            vim.ui.input({ prompt = vim.uv.cwd(), completion = "file" }, function(file_name)
                if file_name then
                    vim.api.nvim_buf_set_name(0, file_name)
                    vim.cmd("write " .. file_name)
                end
            end)
        end,
        { desc = "Write the current buffer to a file prompting for the name" },
    },
}

add_mappings_from_table(global_mappings)

function M.set_lsp_keymappings()
    local lsp_mappings = {
        -- jumping commands
        { "n", "gD", vim.lsp.buf.declaration, silent_buffer },
        { "n", "gI", vim.lsp.buf.implementation, silent_buffer },
        { "n", "gF", vim.lsp.buf.definition, silent_buffer },
        { "n", "gT", vim.lsp.buf.type_definition, silent_buffer },
        { "n", "gR", vim.lsp.buf.references, silent_buffer },

        -- Signature help
        { "n", "K", vim.lsp.buf.hover, silent_buffer },
        { "n", "<C-k>", vim.lsp.buf.signature_help, silent_buffer },

        -- Refactorings
        { "n", "<C-r>r", require("utils.lsp").rename, silent_buffer },
        { { "n", "v" }, "<C-r><space>", vim.lsp.buf.code_action, silent_buffer },
        { "n", "<C-r>f", require("conform").format, silent_buffer },
    }

    add_mappings_from_table(lsp_mappings)
end

function M.set_debugger_keymappings()
    local debugger_mappings = {
        { "n", "<F5>", require("dap").continue, silent },
        { "n", "<F10>", require("dap").step_over, silent },
        { "n", "<F11>", require("dap").step_into, silent },
        { "n", "<F12>", require("dap").step_out, silent },
        { "n", "<space>b", require("dap").toggle_breakpoint, silent },
        { "n", "<space>B", require("dap").set_breakpoint, silent },
        {
            "n",
            "<space>bl",
            function()
                require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end,
        },
        {
            "n",
            "<space>bc",
            function()
                require("dap").set_breakpoint(vim.fn.input("Condition: "))
            end,
        },
        { "n", "<space>dr", require("dap").repl.open, silent },
        { "n", "<space>dl", require("dap").run_last, silent },
    }

    add_mappings_from_table(debugger_mappings)
end

function M.setup_harpoon_keybindings()
    local harpoon_mappings = {
        { "n", "<space>m", require("harpoon.mark").add_file },
        { "n", "<space>M", require("harpoon.ui").toggle_quick_menu },
    }
    add_mappings_from_table(harpoon_mappings)
end

function M.setup_navigator_keybindings()
    -- Window management plugin with tmux integration and better pane resizing
    local window_key = "<C-w>"
    local tmux_navigator_mappings = {
        { { "n", "t" }, window_key .. "h", require("Navigator").left },
        { { "n", "t" }, window_key .. "j", require("Navigator").down },
        { { "n", "t" }, window_key .. "k", require("Navigator").up },
        { { "n", "t" }, window_key .. "l", require("Navigator").right },
    }
    add_mappings_from_table(tmux_navigator_mappings)
end

function M.setup_gitsigns_mappings()
    local git_signs = require("gitsigns")
    local signs_mappings = {
        {
            "n",
            "<space>gs",
            git_signs.stage_hunk,
            silent_buffer .. { desc = "Stage current hunk" },
        },
        {
            "v",
            "<space>gs",
            function()
                git_signs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end,
            silent_buffer .. { desc = "Stage visual selection" },
        },
        {
            "n",
            "<space>gS",
            git_signs.stage_buffer,
            silent_buffer .. { desc = "Stage current buffer" },
        },

        {
            "n",
            "<space>gr",
            git_signs.reset_hunk,
            silent_buffer .. { desc = "Restore current hunk" },
        },
        {
            "v",
            "<space>gr",
            function()
                git_signs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end,
            silent_buffer .. { desc = "Restore visual selection" },
        },
        {
            "n",
            "<space>gR",
            git_signs.reset_buffer,
            silent_buffer .. { desc = "Restore current buffer" },
        },

        {
            "n",
            "<space>gb",
            git_signs.blame_line,
            silent_buffer .. { desc = "View blame for the current line" },
        },

        -- git-fugitive
        {
            "n",
            "<space>gc",
            ":G c<CR>",
            silent_buffer .. { desc = "Commit staged changes" },
        },
        {
            "n",
            "<space>gp",
            ":G push<CR>",
            silent_buffer .. { desc = "Push commits" },
        },
    }

    add_mappings_from_table(signs_mappings)
end

function M.setup_telescope_mappings()
    local telescope_builtins = require("telescope.builtin")
    unmap_key("n", "<C-f>")
    local telescope_mappings = {
        { "n", "<C-p>", telescope_builtins.find_files, silent },
        { "n", "<C-p>g", telescope_builtins.git_files, silent },
        { "n", "<C-f>", telescope_builtins.current_buffer_fuzzy_find, silent },
        { "n", "<C-b>", telescope_builtins.buffers, silent },
        {
            "n",
            "<C-f>s",
            telescope_builtins.lsp_document_symbols,
            { silent = true, desc = " List document symbols" },
        },
        {
            "n",
            "<C-f>ws",
            telescope_builtins.lsp_dynamic_workspace_symbols,
            { silent = true, desc = " List workspace symbols" },
        },
        { "n", "<C-h>", telescope_builtins.help_tags, { silent = true, desc = " Open help" } },
    }

    add_mappings_from_table(telescope_mappings)
end

function M.setup_quarto_mappings()
    local quarto = require("quarto")
    local quarto_mappings = {
        { "n", "<leader>qa", ":QuartoActivate<cr>", silent_buffer },
        { "n", "<leader>qp", quarto.quartoPreview, silent_buffer },
        { "n", "<leader>qq", quarto.quartoClosePreview, silent_buffer },
        { "n", "<leader>qh", ":QuartoHelp ", silent_buffer },
    }

    add_mappings_from_table(quarto_mappings)
end

function M.setup_markdown_mappings(bufnr)
    local markdown_mappings = {
        {
            "n",
            "ds",
            "<Plug>(markdown_delete_emphasis)",
            silent_buffer .. { desc = "Delete surrounding style" },
        },
        {
            "n",
            "cs",
            "<Plug>(markdown_change_emphasis)",
            silent_buffer .. { desc = "Change surrounding style" },
        },
        { "n", "gl", "<Plug>(markdown_add_link)", silent_buffer .. { desc = "Add link over motion" } },
        {
            "v",
            "gl",
            "<Plug>(markdown_add_link_visual)",
            silent_buffer .. { desc = "Add link over visual selection" },
        },
    }
    add_mappings_from_table(markdown_mappings)
end

local snacks_mappings = {
    {
        "n",
        "<space>z",
        function()
            require("snacks").zen()
        end,
        { desc = "Toggle Zen Mode" },
    },
    {
        "n",
        "<space>Z",
        function()
            require("snacks").zen.zoom()
        end,
        { desc = "Toggle Zoom" },
    },
    {
        "n",
        "<space>.",
        function()
            require("snacks").scratch()
        end,
        { desc = "Toggle Scratch Buffer" },
    },
    {
        "n",
        "<space>S",
        function()
            require("snacks").scratch.select()
        end,
        { desc = "Select Scratch Buffer" },
    },
    {
        "n",
        "<space>nh",
        function()
            require("snacks").notifier.show_history()
        end,
        { desc = "Notification History" },
    },
    {
        { "n", "v" },
        "<space>gB",
        function()
            require("snacks").gitbrowse()
        end,
        { desc = "Git Browse" },
    },
    {
        "n",
        "<space>nhh",
        function()
            require("snacks").notifier.hide()
        end,
        { desc = "Dismiss All Notifications" },
    },
    {
        "n",
        "<space>t",
        function()
            require("snacks").terminal()
        end,
        { desc = "Toggle Terminal" },
    },
    {
        "n",
        "<space>n",
        function()
            require("windows").news_window:toggle()
        end,
        { desc = "Toggle Neovim News" },
    },
    {
        "n",
        "<space>h",
        function()
            require("windows").help_window:toggle()
        end,
        { desc = "Toggle the help window" },
    },
}
add_mappings_from_table(snacks_mappings)

M.Snacks_keys = snacks_mappings

local kalula_mappings = {
    {
        "n",
        "<localleader>r",
        function()
            require("kulala").run()
        end,
        silent_buffer .. { desc = "Run the current request" },
    },
    {
        "n",
        "<localleader>ra",
        function()
            require("kulala").run_all()
        end,
        silent_buffer .. { desc = "Run all requests in the current buffer" },
    },
    {
        "n",
        "<localleader>rp",
        function()
            require("kulala").replay()
        end,
        silent_buffer .. { desc = "Replay the last run request" },
    },
    {
        "n",
        "<localleader>ro",
        function()
            require("kulala").open()
        end,
        silent_buffer .. { desc = "Open default UI in default view" },
    },
    {
        "n",
        "<localleader>k",
        function()
            require("kulala").inspect()
        end,
        silent_buffer .. { desc = "Inspect the current request" },
    },
    {
        "n",
        "<nop>",
        function()
            require("kulala").show_stats()
        end,
        silent_buffer .. { desc = "Show the statistics of the last run request" },
    },
    {
        "n",
        "<localleader>s",
        function()
            require("kulala").scratchpad()
        end,
        silent_buffer .. { desc = "Open the scratchpad" },
    },
    {
        "n",
        "<nop>",
        function()
            require("kulala").copy()
        end,
        silent_buffer .. { desc = "Copy the current request (as cURL command) to the clipboard" },
    },
    {
        "n",
        "<nop>",
        function()
            require("kulala").from_curl()
        end,
        silent_buffer
            .. {
                desc = "Parse the cURL command from the clipboard and write the HTTP spec into current buffer. It's useful for importing requests from other tools like browsers",
            },
    },
    {
        "n",
        "<localleader>rq",
        function()
            require("kulala").close()
        end,
        silent_buffer .. { desc = "Close the kulala window and also the current buffer" },
    },
    {
        "n",
        "<nop>",
        function()
            require("kulala").toggle_view()
        end,
        silent_buffer .. { desc = "Toggle between the body and headers view of the last run request" },
    },
    {
        "n",
        "<localleader>f",
        function()
            require("kulala").search()
        end,
        silent_buffer .. { desc = "Searche for all named requests in the current buffer" },
    },
    {
        "n",
        "<localleader>pr",
        function()
            require("kulala").jump_prev()
        end,
        silent_buffer .. { desc = "Jump to the previous request" },
    },
    {
        "n",
        "<localleader>nr",
        function()
            require("kulala").jump_next()
        end,
        silent_buffer .. { desc = "Jump to the next request" },
    },
}
M.Kalula = kalula_mappings
function M.setup_kalula()
    add_mappings_from_table(kalula_mappings)
end

M.schema_mappings = {
    {
        "n",
        "<nop>",
        function()
            require("telescope").extensions.yaml_schema.select_schema()
        end,
        silent_buffer .. { desc = "Select the schema for the current buffer" },
    },
    {
        "n",
        "<nop>",
        function()
            require("telescope").extensions.yaml_schema.select_from_matching_schemas()
        end,
        silent_buffer .. { desc = "Select the schema from schemas matching the buffer" },
    },
    {
        "n",
        "<nop>",
        function()
            require("schema-companion").get_buffer_schema()
        end,
        silent_buffer .. { desc = "Get the schema for the current buffer" },
    },
}

M.ai_mappings = {
    {
        { "n", "v" },
        "<space>cc",
        function()
            require("opencode.api").toggle()
        end,
        silent .. { desc = "Toggle chat window" },
    },
    {
        "n",
        "<space>cca",
        function()
            require("opencode.api").select_agent()
        end,
        silent .. { desc = "View CopilotChat actions" },
    },
    {
        "n",
        "<space>ccm",
        function()
            require("opencode.api").configure_provider()
        end,
        silent .. { desc = "Change CopilotChat model" },
    },
}

function M.setup_ai_mappings()
    add_mappings_from_table(M.ai_mappings)
end

M.treesitter_mappings = {
    {
        { "x", "o" },
        "af",
        function()
            require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end,
        silent_buffer .. { desc = "Select around function" },
    },
    {
        { "x", "o" },
        "if",
        function()
            require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end,
        silent_buffer .. { desc = "Select inner function" },
    },
    {
        { "x", "o" },
        "ac",
        function()
            require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
        end,
        silent_buffer .. { desc = "Select around class" },
    },
    {
        { "x", "o" },
        "ic",
        function()
            require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
        end,
        silent_buffer .. { desc = "Select inner class" },
    },
    {
        "n",
        "<space>ma",
        function()
            require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner", "textobjects")
        end,
        silent_buffer .. { desc = "Swap with next parameter" },
    },
    {
        "n",
        "<space>mA",
        function()
            require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner", "textobjects")
        end,
        silent_buffer .. { desc = "Swap with previous parameter" },
    },
}

M.rustacean_mappings = {
    -- F17 is identical to <S-F5>
    { "n", "<F17>", " :w<CR>:RustLsp runnables<CR>", silent_buffer .. { desc = "Select a runnable target" } },
    { "n", "<F5>", " :w<CR>:RustLsp debuggables<CR>", silent_buffer .. { desc = "Select a debuggable target" } },
    { "n", "<space>t", " :w<CR>:RustTest<CR>", silent_buffer .. { desc = "Run the test under cursor" } },
    { "n", "<space>ta", " :w<CR>:RustTest!<CR>", silent_buffer .. { desc = "Run all test" } },
    {
        "n",
        "<space>k",
        function()
            vim.cmd.RustLsp("openDocs")
        end,
        silent_buffer .. { desc = "Open the external documentation" },
    },
    {
        "n",
        "<space>d",
        function()
            vim.cmd.RustLsp("renderDiagnostic")
        end,
        silent_buffer .. { desc = "Display the diagnostic" },
    },
}

return M
