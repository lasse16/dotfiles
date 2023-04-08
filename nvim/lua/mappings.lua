M = {}

-- utils
local function set_global_key(...)
	vim.api.nvim_set_keymap(...)
end

local function set_buffer_key(bufnr, ...)
	vim.api.nvim_buf_set_keymap(bufnr, ...)
end

local noremap = { noremap = true }
local noremap_silent = { noremap = true, silent = true }
local noremap_expr = { noremap = true, expr = true }

-- Move lines up and down
set_global_key("n", "<A-j>", ":m .+1<CR>==", noremap)
set_global_key("n", "<A-k>", ":m .-2<CR>==", noremap)
set_global_key("v", "<A-k>", ":m '<-2<CR>gv=gv", noremap)
set_global_key("v", "<A-j>", ":m '>+1<CR>gv=gv", noremap)

-- Map <Ctrl-S> to saving the current open document
set_global_key("n", "<C-s>", "<ESC>:update<CR>", noremap)

-- Unbind some useless/annoying default key bindings.
set_global_key("n", "Q", "<Nop>", {}) -- 'Q' in normal mode enters Ex mode. You almost never want this.

-- Close terminal mode with <Esc>
-- stylua: ignore start
set_global_key("t", "<Esc>", [[<C-\><C-n>]], noremap)
set_global_key("t", "<C-w>", [[<C-\><C-n><C-w>]], noremap)
-- stylua: ignore end

print("MAPPINGS COMPLETED")

function M.set_lsp_keymappings(bufnr)
	-- See `:help vim.lsp.*` for documentation on any of the below functions

	local function set_current_buffer_normal_mode(...)
		set_buffer_key(bufnr, "n", ...)
	end

	set_current_buffer_normal_mode("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", noremap_silent)
	set_current_buffer_normal_mode("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", noremap_silent)
	set_current_buffer_normal_mode("gF", "<cmd>lua vim.lsp.buf.definition()<CR>", noremap_silent)
	set_current_buffer_normal_mode("gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", noremap_silent)
	set_current_buffer_normal_mode("gR", "<cmd>lua vim.lsp.buf.references()<CR>", noremap_silent)

	set_current_buffer_normal_mode("K", "<cmd>lua vim.lsp.buf.hover()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", noremap_silent)

	set_current_buffer_normal_mode("<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", noremap_silent)
	set_current_buffer_normal_mode(
		"<space>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		noremap_silent
	)
	set_current_buffer_normal_mode("<C-r>r", "<cmd>lua vim.lsp.buf.rename()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<C-r><space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<C-r>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", noremap_silent)
	set_buffer_key(bufnr, "v", "<C-r><space>", ":<c-u>lua vim.lsp.buf.range_code_action()<cr>", noremap)

	set_current_buffer_normal_mode(
		"<space>e",
		"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
		noremap_silent
	)
	set_current_buffer_normal_mode("[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", noremap_silent)
	set_current_buffer_normal_mode("]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", noremap_silent)
	print("LSP Mappings set")
end

function M.set_debugger_keymappings()
	vim.cmd([[
		nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
		nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
		nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
		nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
		nnoremap <silent> <space>b :lua require'dap'.toggle_breakpoint()<CR>
		nnoremap <silent> <space>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
		nnoremap <silent> <space>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
		nnoremap <silent> <space>dr :lua require'dap'.repl.open()<CR>
		nnoremap <silent> <space>dl :lua require'dap'.run_last()<CR>
		]])
	print("Debugger mappings set")
end

function M.setup_harpoon_keybindings()
	vim.cmd([[
		nnoremap <silent> <space>m :lua require("harpoon.mark").add_file()<CR>
		nnoremap <silent> <space>M :lua require("harpoon.ui").toggle_quick_menu()<CR>
		nnoremap <silent> <space>M1 :lua require("harpoon.ui").nav_file(1)<CR>
		nnoremap <silent> <space>M2 :lua require("harpoon.ui").nav_file(2)<CR>
		nnoremap <silent> <space>M3 :lua require("harpoon.ui").nav_file(3)<CR>
		]])
	print("Harpoon mappings set")
end

function M.setup_navigator_keybindings()
	-- Window management plugin with tmux integration and better pane resizing
	local window_key = '<C-w>'
	vim.keymap.set({'n','t'}, window_key .. 'h', require('Navigator').left)
	vim.keymap.set({'n','t'}, window_key .. 'j', require('Navigator').down)
	vim.keymap.set({'n','t'}, window_key .. 'k', require('Navigator').up)
	vim.keymap.set({'n','t'}, window_key .. 'l', require('Navigator').right)
	print("Navigator mappings set")
end

return M
