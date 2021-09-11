" Using the default vim color scheme is fine with me, in combinations with the nord-inspired terminal scheme.
" But there are two additions I want to make.
" Source this file in " Using the default color scheme is fine with me.
" But there are only a few additions I want to make.
"

" Darken the shown line numbers and show them in italic
highlight LineNr ctermfg=darkGrey cterm=italic term=italic


" Display comments in italic
highlight Comment ctermfg=darkGrey cterm=italic term=italic


" Display the line seperating vertical panes as dark pipes
highlight VertSplit ctermbg=NONE ctermfg=black cterm=NONE

" Display comments in italic
highlight EndOfBuffer ctermfg=black cterm=italic term=italic

" Change the background of the completion window
highlight Pmenu ctermbg=black ctermfg=darkGrey

" Change the background of the completion window
highlight PmenuSel ctermbg=black ctermfg=white

" Set border of popup and floating windows
highlight FloatBorder ctermbg=black ctermfg=darkGrey

" Darken the background of the Gutter/SignColumn
highlight SignColumn ctermbg=NONE

if has_key(g:plugs,'nvim-lspconfig')
	"default highlight groups for LSP messages
	highlight LspDiagnosticsDefaultError ctermfg=red ctermbg=NONE cterm=italic
	highlight LspDiagnosticsDefaultWarning ctermfg=yellow ctermbg=NONE cterm=italic
	highlight LspDiagnosticsDefaultInformation ctermfg=white ctermbg=NONE cterm=italic
	highlight LspDiagnosticsDefaultHint ctermfg=grey ctermbg=NONE cterm=italic

	" Highlight virtual text
	highlight LspDiagnosticsVirtualTextError ctermfg=red ctermbg=NONE cterm=italic
	highlight LspDiagnosticsVirtualTextWarning ctermfg=yellow ctermbg=NONE cterm=italic
	highlight LspDiagnosticsVirtualTextInformation ctermfg=white ctermbg=NONE cterm=italic
	highlight LspDiagnosticsVirtualTextHint ctermfg=grey ctermbg=NONE cterm=italic

	" Change displays in the sign column
	highlight LspDiagnosticsSignError ctermfg=red ctermbg=NONE cterm=italic
	highlight LspDiagnosticsSignWarning ctermfg=yellow ctermbg=NONE cterm=italic
	highlight LspDiagnosticsSignInformation ctermfg=white ctermbg=NONE cterm=italic
	highlight LspDiagnosticsSignHint ctermfg=grey ctermbg=NONE cterm=italic
endif
