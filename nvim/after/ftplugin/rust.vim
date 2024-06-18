" F17 is identical to <S-F5>
map <buffer> <F17> :w<CR>:RustLsp runnables<CR>
map <buffer> <F5> :w<CR>:RustLsp debuggables<CR>
map <buffer> <space>t :w<CR>:RustTest <CR>
map <buffer> <space>ta :w<CR>:RustTest! <CR>
