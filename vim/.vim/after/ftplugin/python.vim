map <buffer> <S-F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
let b:ale_fixers = ['black']
