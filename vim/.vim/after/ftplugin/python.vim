map <buffer> <S-F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
let b:ale_fixers = ['black']

let b:ale_python_pyls_executable='/home/lasse/.local/share/vim-lsp-settings/servers/pyls-all/venv/bin/pyls'
