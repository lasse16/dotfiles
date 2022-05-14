local installed = require("utils").installed

vim.cmd([[
" Using the default vim color scheme is fine with me, in combinations with the nord-inspired terminal scheme.
" But there are two additions I want to make.
" Source this file in " Using the default color scheme is fine with me.
" But there are only a few additions I want to make.

" Darken the shown line numbers and show them in italic
highlight LineNr ctermfg=darkGrey cterm=italic term=italic guifg=darkGrey gui=italic 


" Display comments in italic
highlight Comment ctermfg=darkGrey cterm=italic term=italic guifg=darkGrey gui=italic 

" Highlight visual selection
highlight Visual ctermbg=darkgrey guibg=darkgrey

" Display the line seperating vertical panes as dark pipes
highlight VertSplit ctermbg=NONE ctermfg=black cterm=NONE guibg=NONE guifg=black gui=NONE

" Display comments in italic
highlight EndOfBuffer ctermfg=black cterm=italic term=italic guifg=black gui=italic

" Change the background of the completion window
highlight Pmenu ctermbg=black ctermfg=darkGrey guibg=black guifg=darkGrey

" Change the background of the completion window
highlight PmenuSel ctermbg=black ctermfg=white guibg=black guifg=white

" Set border of popup and floating windows
highlight FloatBorder ctermbg=black ctermfg=darkGrey guibg=black guifg=darkGrey
" Darken the background of the Gutter/SignColumn
highlight SignColumn ctermbg=NONE guibg=NONE

" Highlight strings in green
highlight String ctermfg=darkgreen ctermbg=NONE guifg=darkgreen guibg=NONE
]])

if installed("nvim-lspconfig") then
	vim.cmd([[
	"default highlight groups for LSP messages
	highlight LspDiagnosticsDefaultError ctermfg=red ctermbg=NONE cterm=underline,italic guifg=red guibg=NONE gui=underline,italic
	highlight LspDiagnosticsDefaultWarning ctermfg=yellow ctermbg=NONE cterm=underline,italic guifg=yellow guibg=NONE gui=underline,italic
	highlight LspDiagnosticsDefaultInformation ctermfg=white ctermbg=NONE cterm=underline,italic guifg=white guibg=NONE gui=underline,italic
	highlight LspDiagnosticsDefaultHint ctermfg=grey ctermbg=NONE cterm=underline,italic guifg=grey guibg=NONE gui=underline,italic

	" Highlight virtual text
	highlight LspDiagnosticsVirtualTextError ctermfg=red ctermbg=NONE cterm=italic guifg=red guibg=NONE gui=italic
	highlight LspDiagnosticsVirtualTextWarning ctermfg=yellow ctermbg=NONE cterm=italic guifg=yellow guibg=NONE gui=italic
	highlight LspDiagnosticsVirtualTextInformation ctermfg=white ctermbg=NONE cterm=italic guifg=white guibg=NONE gui=italic
	highlight LspDiagnosticsVirtualTextHint ctermfg=grey ctermbg=NONE cterm=italic guifg=grey guibg=NONE gui=italic

	" Change displays in the sign column displays in the sign column
	highlight LspDiagnosticsSignError ctermfg=red ctermbg=NONE guifg=red guibg=NONE
	highlight LspDiagnosticsSignWarning ctermfg=yellow ctermbg=NONE guifg=yellow guibg=NONE
	highlight LspDiagnosticsSignInformation ctermfg=white ctermbg=NONE guifg=white guibg=NONE
	highlight LspDiagnosticsSignHint ctermfg=grey ctermbg=NONE guifg=grey guibg=NONE

]])
end

if installed("nvim-treesitter") then
	vim.cmd([[
	"default highlights for treesitter
	highlight TSAttribute ctermfg=darkblue ctermbg=NONE guifg=darkblue guibg=NONE
	highlight link TSCharacter Character
	highlight link TSComment Comment
	highlight link TSConstBuiltin Boolean
	highlight link TSConstMacro Boolean
	highlight link TSError LspDiagnosticsDefaultError
	highlight TSException ctermfg=yellow guifg=yellow
	highlight TSField ctermfg=yellow ctermbg=NONE guifg=yellow guibg=NONE
	highlight TSFunction ctermfg=cyan ctermbg=NONE guifg=cyan guibg=NONE
	highlight link TSFuncBuiltin TSFunction
	highlight link TSFuncMacro TSfunction
	highlight TSKeyword ctermfg=lightgreen ctermbg=NONE guifg=lightgreen guibg=NONE
	highlight TSKeywordFunction ctermfg=magenta ctermbg=NONE guifg=magenta guibg=NONE
	highlight TSKeywordOperator ctermfg=darkgreen ctermbg=NONE guifg=darkgreen guibg=NONE
	highlight link TSKeywordReturn TSKeywordFunction
	highlight link TSMethod TSFunction
	highlight TSParameter ctermfg=darkyellow ctermbg=NONE guifg=darkyellow guibg=NONE
	highlight link TSParameterReference TSParameter
	highlight link TSProperty TSField
	highlight TSPunctDelimiter ctermfg=blue ctermbg=NONE guifg=blue guibg=NONE
	highlight link TSPunctBracket TSPunctDelimiter
	highlight TSPunctSpecial ctermfg=darkmagenta ctermbg=NONE guifg=darkmagenta guibg=NONE
	highlight link TSStringRegex TSString
	highlight TSStringEscape ctermfg=white ctermbg=NONE guifg=white guibg=NONE
	highlight TSStringSpecial ctermfg=darkmagenta ctermbg=NONE guifg=darkmagenta guibg=NONE
	highlight link TSTagDelimiter TSPunctDelimiter
	highlight TSURI ctermfg=lightcyan ctermbg=NONE cterm=underline ctermfg=lightcyan guibg=NONE gui=underline
	highlight TSMath ctermfg=lightgray ctermbg=NONE guifg=lightgray guibg=NONE
	highlight TSTextReference ctermfg=lightgray ctermbg=NONE cterm=italic ctermfg=lightgray guibg=NONE gui=italic
	highlight link TSNote LspDiagnosticsDefaultHint
	highlight link TSWarning LspDiagnosticsDefaultWarning
	highlight link TSDanger LspDiagnosticsDefaultError
	highlight TSType ctermfg=lightcyan ctermbg=NONE guifg=lightcyan guibg=NONE
	highlight TSVariable ctermfg=blue ctermbg=NONE guifg=blue guibg=NONE
	highlight link TSVariableBuiltin TSVariable
	]])
end

if installed("nvim-notify") then
	vim.cmd([[
	highlight NotifyERRORBorder ctermfg=red guifg=red
	highlight NotifyWARNBorder ctermfg=darkyellow guifg=darkyellow
	highlight NotifyINFOBorder ctermfg=gray guifg=gray
	highlight NotifyDEBUGBorder ctermfg=darkgray guifg=darkgray
	highlight NotifyTRACEBorder ctermfg=black guifg=black
	
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
