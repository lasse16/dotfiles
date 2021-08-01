" Move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-k> :m '<-2<CR>gv=gv
vnoremap <A-j> :m '>+1<CR>gv=gv

" Map <Ctrl-S> to saving the current open document
noremap <C-s> <ESC>:w<CR>

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
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr> <Enter> pumvisible() ? "\<C-y>" : "\<Enter>"
inoremap <expr> <ESC> pumvisible() ? "\<C-e>" : "\<ESC>"

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
