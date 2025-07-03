-- This helps templated files by detecting their type with the .tmpl extension  removed
vim.filetype.add({
	extension = {
		tmpl = function(path, bufnr)
			local base_file = vim.fn.fnamemodify(path, ":r")
			local filetype = vim.filetype.match({ buf = bufnr, filename = base_file })
			return filetype or "tmpl"
		end,
	},
})
