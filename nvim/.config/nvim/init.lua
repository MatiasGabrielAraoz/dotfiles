vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4 
vim.o.smartindent = true
vim.o.clipboard = "unnamedplus"
vim.o.mouse = ""
vim.g.mapleader = " "
vim.o.winborder = "rounded"

local vcpkg_root = os.getenv("VCPKG_ROOT") or "/usr/local/vcpkg"
local vcpkg_triplet = os.getenv("VCPKG_TRIPLET") or "x64-linux"
local vcpkg_include = vcpkg_root .. "/installed/" .. vcpkg_triplet .. "/include"

vim.pack.add({
	{ src = "https://github.com/sainnhe/gruvbox-material"},
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter"},
	{ src = "https://github.com/stevearc/oil.nvim"},
	{ src = "https://github.com/echasnovski/mini.pick"},
	{ src = "https://github.com/williamboman/mason.nvim"},
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim"},
	{ src = "https://github.com/neovim/nvim-lspconfig"},
	{ src = "https://github.com/Saghen/blink.cmp"},
	{ src = "https://github.com/folke/which-key.nvim"},
	{ src = "https://github.com/echasnovski/mini.visits"},
	{ src = "https://github.com/echasnovski/mini.extra"},
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/linrongbin16/bufferlist.nvim"},
	{ src= "https://github.com/numToStr/Comment.nvim"},
})

vim.o.background = "dark"
vim.cmd.colorscheme "gruvbox-material"
vim.g.gruvbox_material_background = 'soft'
vim.g.gruvbox_material_foreground = 'material'
vim.gruvbox_material_spell_foreground = 'none'


require("plugins.treesitter")
require("plugins.oil")
require("plugins.mini")
require("plugins.mason")
require("plugins.comment")
require("plugins.blink-cmp")
require("autocmds")


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


