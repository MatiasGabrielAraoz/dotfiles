

vim.keymap.set('n', '<leader>o', function()
	vim.cmd('write') 
	vim.cmd('luafile '  .. vim.fn.stdpath('config') .. '/init.lua')
	vim.notify('Reloaded', vim.log.levels.INFO)
end, { desc = "Save and Reload config" })

vim.keymap.set('n', '<leader>ww', function()
	vim.cmd('write') 
end, { desc = "Save File" })

vim.keymap.set('n', '<leader>wq', function()
	vim.cmd('wqall') 
end, { desc = "Save and quit" })

vim.keymap.set('n', '<leader>wa', function()
	vim.cmd('wall') 
end, { desc = "Save all" })

vim.keymap.set("n", "<leader>qq", function()
	vim.cmd('qall!')
end, {desc = "Quit without saving"})

vim.keymap.set('n', '<leader>jr', function ()
	vim.cmd('!just run')
end, {desc = "just run"})
vim.keymap.set('n', '<leader>jb', function ()
	vim.cmd('!just build')
end, {desc = "just build"})
vim.keymap.set('n', '<leader>jc', function ()
	vim.cmd('!just clean')
end, {desc = "just clean"})

vim.keymap.set('n', '<leader>rp', function ()
	vim.cmd('lua vim.lsp.buf.rename()')
end)

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {
	noremap = true, 
	silent = true }
)

local jobID = 0
vim.keymap.set('n', '<leader>ta', function ()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 5)

	jobID = vim.bo.channel
end, { desc = "Abrir terminal"} )

vim.keymap.set('n', '<leader>tq', function ()
	if jobID ~= 0 then
		vim.fn.chansend(jobID, { "exit \r"})
		jobID = 0
	else
		vim.notify("No hay terminales abiertas", vim.log.levels.WARN)
	end
end, { desc = "Cerrar terminal"})

vim.keymap.set('n', '<M-Up>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<M-Down>', ':resize +2<CR>', { silent = true })
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { silent = true })
