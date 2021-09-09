vim.cmd([[
function! SnippetExpandOrJump() abort
	if has_key(g:plugs,"ultisnips")
		call UltiSnips#ExpandSnippetOrJump()
		return g:ulti_expand_or_jump_res > 0
	endif
	return 0
endfunction


" Shamelessly stolen from https://stackoverflow.com/a/61275100
function! HandleTab() abort
	" Check if we're in a completion menu
	if pumvisible()
		return "\<C-n>"
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

inoremap <silent> <Tab> <C-R>=HandleTab()<CR>
	]])

-- Move lines up and down
noremap={ noremap= true}
vim.api.nvim_set_keymap('n','<A-j>',':m .+1<CR>==', noremap)
vim.api.nvim_set_keymap('n','<A-k>',':m .-2<CR>==', noremap)
vim.api.nvim_set_keymap('v','<A-k>',":m '<-2<CR>gv=gv", noremap)
vim.api.nvim_set_keymap('v','<A-j>',":m '>+1<CR>gv=gv", noremap)

-- Map <Ctrl-S> to saving the current open document
vim.api.nvim_set_keymap('n', '<C-s>', '<ESC>:update<CR>', noremap)

-- Unbind some useless/annoying default key bindings.
vim.api.nvim_set_keymap('n', 'Q' , '<Nop>', {}) -- 'Q' in normal mode enters Ex mode. You almost never want this.

-- Set up popup menu navigation
noremap_expr={ noremap=true, expr=true }
vim.api.nvim_set_keymap('i', '<S-TAB>', 'pumvisible() ? "<C-p>" : "<S-TAB>" ', noremap_expr)
vim.api.nvim_set_keymap('i', '<Enter>', 'pumvisible() ? "<C-y>" : "<Enter>" ', noremap_expr)
vim.api.nvim_set_keymap('i', '<Esc>', 'pumvisible() ? "<C-e>" : "<Esc>" ', noremap_expr)

print('MAPPINGS COMPLETED')
