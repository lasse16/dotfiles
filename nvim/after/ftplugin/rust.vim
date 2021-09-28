function! Start_debugger_server_and_attach() abort
	lua os.execute('/home/lasse/.local/share/dap/lldb/adapter/codelldb' .. ' --port ' .. '4000 &')
	lua	require('dap').continue()
endfunction

" Override rust debugger start, to also start the lldb-to-dap server
nnoremap <buffer> <F5> :call Start_debugger_server_and_attach()<CR>
