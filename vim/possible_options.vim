" run configuration files stored in every subdirectory.
" This allows to store config in plugin directories, so that deletion works fine with the config
runtime **/config.vim

" Option for ale linting to start2
" When you modify a buffer.                - |g:ale_lint_on_text_changed|
" On leaving insert mode.                  - |g:ale_lint_on_insert_leave|
" When you open a new or modified buffer.  - |g:ale_lint_on_enter|
" When you save a buffer.                  - |g:ale_lint_on_save|
" When the filetype changes for a buffer.  - |g:ale_lint_on_filetype_changed|
" If ALE is used to check code manually.   - |:ALELint|

" Ale Auto fix options
" For convenience, a plug mapping is defined for |ALEFix|, so you can set up a
" keybind easily for fixing files. 

  " Bind F8 to fixing problems with ALE
  " nmap <F8> <Plug>(ale_fix)

" Files can be fixed automatically with the following options, which are all off
" by default.

"|g:ale_fix_on_save| - Fix files when they are saved.

"LET ALE USE THE FIXERS/LINTERS DEFINED IN THE LSP_VENV in
"~/.local/share/vim-lsp-settings/servers
