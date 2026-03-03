-- Lugar para añadir los AutoCmds.



vim.api.nvim_create_autocmd('TermOpen', {
	group = vim.api.nvim_create_augroup('Custom-term-open', {clear = true}),
	callback = function ()
		vim.o.number = false
		vim.o.relativenumber = false
	end
})
