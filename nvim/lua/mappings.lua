M = {}

vim.cmd([[
function! SnippetExpandOrJump() abort
	if has_key(g:plugs,"ultisnips")
		call UltiSnips#ExpandSnippetOrJump()
		return g:ulti_expand_or_jump_res > 0
	endif
	return 0
endfunction

function! CompletionWindowVisible() abort
	return luaeval("require'cmp'.visible()")
endfunction

" Shamelessly stolen from https://stackoverflow.com/a/61275100
function! HandleTab() abort
	" Check if we're in a completion menu
	if pumvisible()
		return "\<C-n>"
	endif
	if CompletionWindowVisible()
		lua require'cmp'.select_next_item()
		return ""
	endif
	if SnippetExpandOrJump()
		return ""
	endif
	" Then check if we're indenting.
	let col = col('.') - 1
	if !col || getline('.')[col - 1] =~ '\s'
		return "\<Tab>"
	endif
	lua require('cmp').complete()
	return ""
endfunction

function! HandleShiftTab() abort
	" Check if we're in a completion menu
	if pumvisible()
		return "\<C-p>"
	endif
	if CompletionWindowVisible()
		lua require'cmp'.select_prev_item()
		return ""
	endif
	return "\<S-Tab>"
endfunction

inoremap <silent> <Tab> <C-R>=HandleTab()<CR>
inoremap <silent> <S-Tab> <C-R>=HandleShiftTab()<CR>
	]])

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

-- Set up popup menu navigation
set_global_key("i", "<Enter>", 'pumvisible() ? "<C-y>" : "<Enter>" ', noremap_expr)
set_global_key("i", "<Esc>", 'pumvisible() ? "<C-e>" : "<Esc>" ', noremap_expr)

print("MAPPINGS COMPLETED")

function M.set_lsp_keymappings(bufnr)
	-- See `:help vim.lsp.*` for documentation on any of the below functions

	local function set_current_buffer_normal_mode(...)
		set_buffer_key(bufnr, "n", ...)
	end

	set_current_buffer_normal_mode("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", noremap_silent)
	set_current_buffer_normal_mode("K", "<cmd>lua vim.lsp.buf.hover()<CR>", noremap_silent)
	set_current_buffer_normal_mode("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", noremap_silent)
	set_current_buffer_normal_mode(
		"<space>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		noremap_silent
	)
	set_current_buffer_normal_mode("<C-F12>", "<cmd>lua vim.lsp.buf.type_definition()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<C-r>r", "<cmd>lua vim.lsp.buf.rename()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<C-r><space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<S-F12>", "<cmd>lua vim.lsp.buf.references()<CR>", noremap_silent)
	set_current_buffer_normal_mode(
		"<space>e",
		"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
		noremap_silent
	)
	set_current_buffer_normal_mode("[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", noremap_silent)
	set_current_buffer_normal_mode("]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", noremap_silent)
	set_current_buffer_normal_mode("<C-r>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", noremap_silent)
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

return M
