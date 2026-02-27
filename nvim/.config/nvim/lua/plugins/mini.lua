require("mini.visits").setup()
require("mini.extra").setup()
require("mini.pick").setup()
vim.keymap.set("n", "<leader>fd", function ()
	local dir = vim.fn.expand("%:p:h")
	require('mini.pick').builtin.files({ cwd = dir}) 
end, {desc = "Pick File with mini.pick"})

vim.keymap.set('n', '<leader>fp', function ()
	require('mini.extra').pickers.visit_paths()
end, {desc = 'Recent Projects'})


vim.keymap.set('n', '<leader>b', function ()
	local dir = vim.fn.expand("%:p:h")
	require('mini.pick').builtin.buffers({ cwd = dir })
end, {desc = 'Buffers List'})
