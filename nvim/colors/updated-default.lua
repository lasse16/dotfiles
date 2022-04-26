local installed = require("utils").installed

vim.cmd([[
" Using the default vim color scheme is fine with me, in combinations with the nord-inspired terminal scheme.
" But there are two additions I want to make.
" Source this file in " Using the default color scheme is fine with me.
" But there are only a few additions I want to make.

" Darken the shown line numbers and show them in italic
highlight LineNr ctermfg=darkGrey cterm=italic term=italic


" Display comments in italic
highlight Comment ctermfg=darkGrey cterm=italic term=italic

" Highlight visual selection
highlight Visual ctermbg=darkgrey

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

" Highlight strings in green
highlight String ctermfg=darkgreen ctermbg=NONE
]])

if installed("nvim-lspconfig") then
	vim.cmd([[
	"default highlight groups for LSP messages
	highlight LspDiagnosticsDefaultError ctermfg=red ctermbg=NONE cterm=underline,italic
	highlight LspDiagnosticsDefaultWarning ctermfg=yellow ctermbg=NONE cterm=underline,italic
	highlight LspDiagnosticsDefaultInformation ctermfg=white ctermbg=NONE cterm=underline,italic
	highlight LspDiagnosticsDefaultHint ctermfg=grey ctermbg=NONE cterm=underline,italic

	" Highlight virtual text
	highlight LspDiagnosticsVirtualTextError ctermfg=red ctermbg=NONE cterm=italic
	highlight LspDiagnosticsVirtualTextWarning ctermfg=yellow ctermbg=NONE cterm=italic
	highlight LspDiagnosticsVirtualTextInformation ctermfg=white ctermbg=NONE cterm=italic
	highlight LspDiagnosticsVirtualTextHint ctermfg=grey ctermbg=NONE cterm=italic

	" Change displays in the sign column
	highlight LspDiagnosticsSignError ctermfg=red ctermbg=NONE
	highlight LspDiagnosticsSignWarning ctermfg=yellow ctermbg=NONE
	highlight LspDiagnosticsSignInformation ctermfg=white ctermbg=NONE
	highlight LspDiagnosticsSignHint ctermfg=grey ctermbg=NONE

]])
end

if installed("nvim-treesitter") then
	vim.cmd([[
	"default highlights for treesitter
	highlight TSAttribute ctermfg=darkblue ctermbg=NONE
	highlight link TSCharacter Character
	highlight link TSComment Comment
	highlight link TSConstBuiltin Boolean
	highlight link TSConstMacro Boolean
	highlight link TSError LspDiagnosticsDefaultError
	highlight TSException ctermfg=yellow
	highlight TSField ctermfg=yellow ctermbg=NONE
	highlight TSFunction ctermfg=cyan ctermbg=NONE
	highlight link TSFuncBuiltin TSFunction
	highlight link TSFuncMacro TSfunction
	highlight TSKeyword ctermfg=lightgreen ctermbg=NONE
	highlight TSKeywordFunction ctermfg=magenta ctermbg=NONE
	highlight TSKeywordOperator ctermfg=darkgreen ctermbg=NONE
	highlight link TSKeywordReturn TSKeywordFunction
	highlight link TSMethod TSFunction
	highlight TSParameter ctermfg=darkyellow ctermbg=NONE
	highlight link TSParameterReference TSParameter
	highlight link TSProperty TSField
	highlight TSPunctDelimiter ctermfg=blue ctermbg=NONE
	highlight link TSPunctBracket TSPunctDelimiter
	highlight TSPunctSpecial ctermfg=darkmagenta ctermbg=NONE
	highlight link TSStringRegex TSString
	highlight TSStringEscape ctermfg=white ctermbg=NONE
	highlight TSStringSpecial ctermfg=darkmagenta ctermbg=NONE
	highlight link TSTagDelimiter TSPunctDelimiter
	highlight TSURI ctermfg=lightcyan ctermbg=NONE cterm=underline
	highlight TSMath ctermfg=lightgray ctermbg=NONE
	highlight TSTextReference ctermfg=lightgray ctermbg=NONE cterm=italic
	highlight link TSNote LspDiagnosticsDefaultHint
	highlight link TSWarning LspDiagnosticsDefaultWarning
	highlight link TSDanger LspDiagnosticsDefaultError
	highlight TSType ctermfg=lightcyan ctermbg=NONE
	highlight TSVariable ctermfg=blue ctermbg=NONE
	highlight link TSVariableBuiltin TSVariable
	]])
end

if installed("nvim-notify") then
	vim.cmd([[
	highlight NotifyERRORBorder ctermfg=red
	highlight NotifyWARNBorder ctermfg=darkyellow
	highlight NotifyINFOBorder ctermfg=gray
	highlight NotifyDEBUGBorder ctermfg=darkgray
	highlight NotifyTRACEBorder ctermfg=black
	
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
