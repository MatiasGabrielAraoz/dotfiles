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
vim.o.background = "dark"


local vcpkg_root = os.getenv("VCPKG_ROOT") or "/usr/local/vcpkg"
local vcpkg_triplet = os.getenv("VCPKG_TRIPLET") or "x64-linux"
local vcpkg_include = vcpkg_root .. "/installed/" .. vcpkg_triplet .. "/include"

vim.pack.add({
	{ src = "https://github.com/sainnhe/gruvbox-material" },
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
	{ src = "https://github.com/numToStr/Comment.nvim"},
	{ src = "https://github.com/declancm/cinnamon.nvim"},
	{ src = "https://github.com/kylechui/nvim-surround"}
})

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
require("plugins.cinnamon")
require("plugins.surround")
require("autocmds")
require("keymaps")

vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })

