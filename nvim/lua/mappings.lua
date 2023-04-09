M = {}

-- utils
local function map_key(...)
	vim.keymap.set(...)
end

local silent_buffer = { buffer = true, silent = true }

-- Move lines up and down
map_key("n", "<A-j>", ":m .+1<CR>==")
map_key("n", "<A-k>", ":m .-2<CR>==")
map_key("v", "<A-k>", ":m '<-2<CR>gv=gv")
map_key("v", "<A-j>", ":m '>+1<CR>gv=gv")

-- Map <Ctrl-S> to saving the current open document
map_key("n", "<C-s>", "<ESC>:update<CR>")

-- Unbind some useless/annoying default key bindings.
map_key("n", "Q", "<Nop>", {}) -- 'Q' in normal mode enters Ex mode. You almost never want this.

-- Close terminal mode with <Esc>
-- stylua: ignore start
map_key("t", "<Esc>", [[<C-\><C-n>]])
map_key("t", "<C-w>", [[<C-\><C-n><C-w>]])
-- stylua: ignore end

print("MAPPINGS COMPLETED")

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
		{ "n", "<C-r>r", vim.lsp.buf.rename, silent_buffer },
		{ { "n", "v" }, "<C-r><space>", vim.lsp.buf.code_action, silent_buffer },
		{ "n", "<C-r>f", vim.lsp.buf.format, silent_buffer },

		-- diagnostics
		{ "n", "<space>e", vim.diagnostic.open_float, silent_buffer },
		{ "n", "[d", vim.diagnostic.goto_prev, silent_buffer },
		{ "n", "]d", vim.diagnostic.goto_next, silent_buffer },
		{ "n", "<space>q", vim.diagnostic.setloclist, silent_buffer },
	}

	for _, opts in pairs(lsp_mappings) do
		map_key(unpack(opts))
	end
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
	vim.keymap.set({ 'n', 't' }, window_key .. 'h', require('Navigator').left)
	vim.keymap.set({ 'n', 't' }, window_key .. 'j', require('Navigator').down)
	vim.keymap.set({ 'n', 't' }, window_key .. 'k', require('Navigator').up)
	vim.keymap.set({ 'n', 't' }, window_key .. 'l', require('Navigator').right)
	print("Navigator mappings set")
end

return M
