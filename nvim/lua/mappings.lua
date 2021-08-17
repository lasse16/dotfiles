vim.cmd([[
" Move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-k> :m '<-2<CR>gv=gv
vnoremap <A-j> :m '>+1<CR>gv=gv

" Map <Ctrl-S> to saving the current open document
nnoremap <C-s> <ESC>:update<CR>

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.


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
	"TODO Trigger  completion here
	return "\<Tab>"
endfunction

inoremap <silent> <Tab> <C-R>=HandleTab()<CR>
	]])

-- Set up popup menu navigation
noremap_expr={ noremap=true, expr=true }
vim.api.nvim_set_keymap('i', '<S-TAB>', 'pumvisible() ? "<C-p>" : "<S-TAB>" ', noremap_expr)
vim.api.nvim_set_keymap('i', '<Enter>', 'pumvisible() ? "<C-y>" : "<Enter>" ', noremap_expr)
vim.api.nvim_set_keymap('i', '<Esc>', 'pumvisible() ? "<C-e>" : "<Esc>" ', noremap_expr)

print('MAPPINGS COMPLETED')
