local installed = require("utils").installed

vim.cmd([[
" Using the default vim color scheme is fine with me, in combinations with the nord-inspired terminal scheme.
" But there are two additions I want to make.
" Source this file in " Using the default color scheme is fine with me.
" But there are only a few additions I want to make.

" Darken the shown line numbers and show them in italic
highlight LineNr ctermfg=darkGrey cterm=italic term=italic guifg=#4c566a gui=italic 


" Display comments in italic
highlight Comment ctermfg=darkGrey cterm=italic term=italic guifg=#4c566a gui=italic 

" Highlight visual selection
highlight Visual ctermbg=darkgrey guibg=#3c3c3c 

" Display the line seperating vertical panes as dark pipes
highlight VertSplit ctermbg=NONE ctermfg=black cterm=NONE guibg=NONE guifg=#0e0e0e gui=NONE

" Darken end of file symbols in line number column
highlight EndOfBuffer ctermfg=black cterm=italic term=italic guifg=#0e0e0e gui=italic

" Change the background of the completion window
highlight Pmenu ctermbg=black ctermfg=darkGrey guibg=#0e1316 guifg=#4c566a

" Change the background of the selected item in completion window
highlight PmenuSel ctermbg=black ctermfg=white guibg=#0e1316 guifg=#f6fffe

" Set border of popup and floating windows
highlight FloatBorder ctermbg=black ctermfg=darkGrey guibg=#0e1316 guifg=#4c566a

" Darken the background of the Gutter/SignColumn
highlight SignColumn ctermbg=NONE guibg=NONE

" Highlight strings in green
highlight String ctermfg=darkgreen ctermbg=NONE guifg=#6e965d guibg=NONE
]])

if installed("nvim-lspconfig") then
	vim.cmd([[
	"default highlight groups for LSP messages
	highlight LspDiagnosticsDefaultError ctermfg=red ctermbg=NONE cterm=underline,italic guifg=#e07e7f guibg=NONE gui=underline,italic
	highlight LspDiagnosticsDefaultWarning ctermfg=yellow ctermbg=NONE cterm=underline,italic guifg=#e0da74 guibg=NONE gui=underline,italic
	highlight LspDiagnosticsDefaultInformation ctermfg=white ctermbg=NONE cterm=underline,italic guifg=#f6fffe guibg=NONE gui=underline,italic
	highlight LspDiagnosticsDefaultHint ctermfg=grey ctermbg=NONE cterm=underline,italic guifg=#4c566a guibg=NONE gui=underline,italic

	" Highlight virtual text
	highlight LspDiagnosticsVirtualTextError ctermfg=red ctermbg=NONE cterm=italic guifg=#e07e7f guibg=NONE gui=italic
	highlight LspDiagnosticsVirtualTextWarning ctermfg=yellow ctermbg=NONE cterm=italic guifg=#e0da74 guibg=NONE gui=italic
	highlight LspDiagnosticsVirtualTextInformation ctermfg=white ctermbg=NONE cterm=italic guifg=#f6fffe guibg=NONE gui=italic
	highlight LspDiagnosticsVirtualTextHint ctermfg=grey ctermbg=NONE cterm=italic guifg=#4c566a guibg=NONE gui=italic

	" Change displays in the sign column displays in the sign column
	highlight LspDiagnosticsSignError ctermfg=red ctermbg=NONE guifg=#e07e7f guibg=NONE
	highlight LspDiagnosticsSignWarning ctermfg=yellow ctermbg=NONE guifg=#e0da74 guibg=NONE
	highlight LspDiagnosticsSignInformation ctermfg=white ctermbg=NONE guifg=#f6fffe guibg=NONE
	highlight LspDiagnosticsSignHint ctermfg=grey ctermbg=NONE guifg=#4c566a guibg=NONE

]])
end

if installed("nvim-treesitter") then
	vim.cmd([[
	"default highlights for treesitter
	highlight TSAttribute ctermfg=darkblue ctermbg=NONE guifg=#5867a1 guibg=NONE
	highlight link TSCharacter Character
	highlight link TSComment Comment
	highlight link TSConstBuiltin Boolean
	highlight link TSConstMacro Boolean
	highlight link TSError LspDiagnosticsDefaultError
	highlight TSException ctermfg=yellow guifg=#e0da74
	highlight TSField ctermfg=yellow ctermbg=NONE guifg=#e0da74 guibg=NONE
	highlight TSFunction ctermfg=cyan ctermbg=NONE guifg=#8fbcbb guibg=NONE
	highlight link TSFuncBuiltin TSFunction
	highlight link TSFuncMacro TSfunction
	highlight TSKeyword ctermfg=lightgreen ctermbg=NONE guifg=lightgreen guibg=NONE
	highlight TSKeywordFunction ctermfg=magenta ctermbg=NONE guifg=#cc9ebc guibg=NONE
	highlight TSKeywordOperator ctermfg=darkgreen ctermbg=NONE guifg=#6e965d guibg=NONE
	highlight link TSKeywordReturn TSKeywordFunction
	highlight link TSMethod TSFunction
	highlight TSParameter ctermfg=darkyellow ctermbg=NONE guifg=#e0da74 guibg=NONE
	highlight link TSParameterReference TSParameter
	highlight link TSProperty TSField
	highlight TSPunctDelimiter ctermfg=blue ctermbg=NONE guifg=#909dde guibg=NONE
	highlight link TSPunctBracket TSPunctDelimiter
	highlight TSPunctSpecial ctermfg=darkmagenta ctermbg=NONE guifg=#a872a6 guibg=NONE
	highlight link TSStringRegex TSString
	highlight TSStringEscape ctermfg=white ctermbg=NONE guifg=#f6fffe guibg=NONE
	highlight TSStringSpecial ctermfg=darkmagenta ctermbg=NONE guifg=#a872a6 guibg=NONE
	highlight link TSTagDelimiter TSPunctDelimiter
	highlight TSURI ctermfg=lightcyan ctermbg=NONE cterm=underline guifg=#a0a0a0 guibg=NONE gui=underline
	highlight TSMath ctermfg=lightgray ctermbg=NONE guifg=#a0a0a0 guibg=NONE
	highlight TSTextReference ctermfg=lightgray ctermbg=NONE cterm=italic guifg=#a0a0a0 guibg=NONE gui=italic
	highlight link TSNote LspDiagnosticsDefaultHint
	highlight link TSWarning LspDiagnosticsDefaultWarning
	highlight link TSDanger LspDiagnosticsDefaultError
	highlight TSType ctermfg=lightcyan ctermbg=NONE guifg=#8fbcbb guibg=NONE
	highlight TSVariable ctermfg=blue ctermbg=NONE guifg=#909dde guibg=NONE
	highlight link TSVariableBuiltin TSVariable
	]])
end

if installed("nvim-notify") then
	vim.cmd([[
	highlight NotifyERRORBorder ctermfg=red guifg=#e07e7f
	highlight NotifyWARNBorder ctermfg=darkyellow guifg=#e0da74
	highlight NotifyINFOBorder ctermfg=gray guifg=#a0a0a0
	highlight NotifyDEBUGBorder ctermfg=darkgray guifg=#4c566a
	highlight NotifyTRACEBorder ctermfg=black guifg=#0e1316
	
	highlight link NotifyERRORIcon NotifyERRORBorder
	highlight link NotifyWARNIcon NotifyWARNBorder  
	highlight link NotifyINFOIcon NotifyINFOBorder  
	highlight link NotifyDEBUGIcon NotifyDEBUGBorder  
	highlight link NotifyTRACEIcon NotifyTRACEBorder  

	highlight link NotifyERRORTitle NotifyERRORBorder   
	highlight link NotifyWARNTitle NotifyWARNBorder 
	highlight link NotifyINFOTitle NotifyINFOBorder 
	highlight link NotifyDEBUGTitle NotifyDEBUGBorder   
	highlight link NotifyTRACETitle NotifyTRACEBorder   
	]])
end
