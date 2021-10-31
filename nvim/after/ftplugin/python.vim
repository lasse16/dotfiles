" F17 is identical to <S-F5>
map <buffer> <F17> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
