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

local function add_mappings_from_table(mappings)
	for _, opts in pairs(mappings) do
		map_key(unpack(opts))
	end
end

------------------------------------------------------

local global_mappings = {
	-- Move lines up and down
	{ "n", "<A-j>",     ":m .+1<CR>==" },
	{ "n", "<A-k>",     ":m .-2<CR>==" },
	{ "v", "<A-k>",     ":m '<-2<CR>gv=gv" },
	{ "v", "<A-j>",     ":m '>+1<CR>gv=gv" },

	-- Map <Ctrl-S> to saving the current open document
	{ "n", "<C-s>",     "<ESC>:update<CR>" },

	-- Unbind some useless/annoying default key bindings.
	{ "n", "Q",         "<Nop>",                   {} }, -- 'Q' in normal mode enters Ex mode. You almost never want this.

	-- Close terminal mode with <Esc>
	-- stylua: ignore start
	{ "t", "<Esc>",     [[<C-\><C-n>]] },
	{ "t", "<C-w>",     [[<C-\><C-n><C-w>]] },
	-- stylua: ignore end

	-- Remove highlighting
	{ "n", "<Esc>",     "<cmd>nohlsearch<CR>" },

	-- make ZW behave like ZZ and ZQ
	{ "n", "ZW",        "<ESC>:update<CR>" },

	-- diagnostics
	{ "n", "<space>e",  vim.diagnostic.open_float, silent_buffer },
	{ "n", "[d",        vim.diagnostic.goto_prev,  silent_buffer },
	{ "n", "]d",        vim.diagnostic.goto_next,  silent_buffer },
	{ "n", "<space>q",  vim.diagnostic.setloclist, silent_buffer },

	-- git
	{ "n", "<space>gc", ":G c<CR>",                silent_buffer },
	{ "n", "<space>gp", ":G push<CR>",             silent_buffer },

	-- 60% keyboard adjust
	{ "c", "<c-j>",     "<Down>",                  {} },
	{ "c", "<C-k>",     "<Up>",                    {} },
}

add_mappings_from_table(global_mappings)

function M.set_lsp_keymappings()
	local lsp_mappings = {
		-- jumping commands
		{ "n",          "gD",           vim.lsp.buf.declaration,     silent_buffer },
		{ "n",          "gI",           vim.lsp.buf.implementation,  silent_buffer },
		{ "n",          "gF",           vim.lsp.buf.definition,      silent_buffer },
		{ "n",          "gT",           vim.lsp.buf.type_definition, silent_buffer },
		{ "n",          "gR",           vim.lsp.buf.references,      silent_buffer },

		-- Signature help
		{ "n",          "K",            vim.lsp.buf.hover,           silent_buffer },
		{ "n",          "<C-k>",        vim.lsp.buf.signature_help,  silent_buffer },

		-- Refactorings
		{ "n",          "<C-r>r",       vim.lsp.buf.rename,          silent_buffer },
		{ { "n", "v" }, "<C-r><space>", vim.lsp.buf.code_action,     silent_buffer },
		{ "n",          "<C-r>f",       vim.lsp.buf.format,          silent_buffer },
	}

	add_mappings_from_table(lsp_mappings)
end

function M.set_debugger_keymappings()
	local debugger_mappings = {
		{ "n", "<F5>",      require("dap").continue,          silent },
		{ "n", "<F10>",     require("dap").step_over,         silent },
		{ "n", "<F11>",     require("dap").step_into,         silent },
		{ "n", "<F12>",     require("dap").step_out,          silent },
		{ "n", "<space>b",  require("dap").toggle_breakpoint, silent },
		{ "n", "<space>B",  require("dap").set_breakpoint,    silent },
		{ "n", "<space>lp", require("dap").set_breakpoint,    silent },
		{ "n", "<space>dr", require("dap").repl.open,         silent },
		{ "n", "<space>dl", require("dap").run_last,          silent },
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
		map_key({ "n", "t" }, window_key .. "h", require("Navigator").left),
		map_key({ "n", "t" }, window_key .. "j", require("Navigator").down),
		map_key({ "n", "t" }, window_key .. "k", require("Navigator").up),
		map_key({ "n", "t" }, window_key .. "l", require("Navigator").right),
	}
	add_mappings_from_table(tmux_navigator_mappings)
end

function M.setup_gitsigns_mappings()
	local git_signs = require("gitsigns")
	local signs_mappings = {
		{ "v", "<space>gs", git_signs.stage_hunk,      silent_buffer },
		{ "n", "<space>gs", git_signs.stage_hunk,      silent_buffer },
		{ "n", "<space>gu", git_signs.undo_stage_hunk, silent_buffer },
		{ "n", "<space>gb", git_signs.blame_line,      silent_buffer },
	}

	add_mappings_from_table(signs_mappings)
end

function M.setup_telescope_mappings()
	local telescope_builtins = require("telescope.builtin")
	unmap_key("n", "<C-f>")
	local telescope_mappings = {
		{ "n", "<C-p>",  telescope_builtins.find_files,                silent },
		{ "n", "<C-p>g", telescope_builtins.git_files,                 silent },
		{ "n", "<C-f>",  telescope_builtins.current_buffer_fuzzy_find, silent },
		{ "n", "<C-b>",  telescope_builtins.buffers,                   silent },
	}

	add_mappings_from_table(telescope_mappings)
end

function M.setup_quarto_mappings()
	local quarto = require("quarto")
	local quarto_mappings = {
		{ "n", "<leader>qa", ":QuartoActivate<cr>",     silent_buffer },
		{ "n", "<leader>qp", quarto.quartoPreview,      silent_buffer },
		{ "n", "<leader>qq", quarto.quartoClosePreview, silent_buffer },
		{ "n", "<leader>qh", ":QuartoHelp ",            silent_buffer },
	}

	add_mappings_from_table(quarto_mappings)
end

function M.setup_markdown_mappings(bufnr)
	local markdown_mappings = {
		{ "n", "ds", '<Plug>(markdown_delete_emphasis)',          { silent = true, buffer = bufnr, desc = "Delete surrounding style" } },
		{ "n", "cs", '<Plug>(markdown_change_emphasis)',          { silent = true, buffer = bufnr, desc = "Change surrounding style" } },
		{ "n", "gl", '<Plug>(markdown_add_link)',                 { silent = true, buffer = bufnr, desc = "Add link over motion" } },
		{ "v", "gl", '<Plug>(markdown_add_link_visual)',          { silent = true, buffer = bufnr, desc = "Add link over visual selection" } },
		{ "n", "gx", '<Plug>(markdown_follow_link)',              { silent = true, buffer = bufnr, desc = "Follow paths and urls, paths are opened in neovim and urls in browser" } },
		{ "n", "gX", '<Plug>(markdown_follow_link_default_app)`', { silent = true, buffer = bufnr, desc = "Follow paths and urls, everything is opened in the default app" } },
	}
	add_mappings_from_table(markdown_mappings)
end

return M
