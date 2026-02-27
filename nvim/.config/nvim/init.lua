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
})

vim.o.background = "dark"
vim.cmd.colorscheme "gruvbox-material"
vim.g.gruvbox_material_background = 'soft'
vim.g.gruvbox_material_foreground = 'material'
vim.gruvbox_material_spell_foreground = 'none'


require("plugins.treesitter")
require("plugins.oil")
require("plugins.mini")

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls"},
})


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
local blink = require('blink.cmp')

local check_backspace = function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s') ~= nil
end

blink.setup({
	signature = {enabled = true},
	
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = {
			force_version = "1.0.0"
		}
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
		},
		accept = {
			create_undo_point = true,
		},
		trigger = {
			show_on_insert = true,
			show_on_insert_on_trigger_character = true,
		},
		ghost_text = {enabled = true},
	},
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
		providers = {
            lsp = { name = 'lsp', module = 'blink.cmp.sources.lsp' },
            path = { name = 'path', module = 'blink.cmp.sources.path' },
            snippets = { name = 'snippets', module = 'blink.cmp.sources.snippets' },
            buffer = { name = 'buffer', module = 'blink.cmp.sources.buffer' },
		},
	},
	
	keymap = {
		preset = "default",
		['<Tab>'] = {
			function(cmp)
				if cmp.is_visible() then
					cmp.accept()
					return true
				end
				if not check_backspace() then
					cmp.show()
					return true
				end
				return false 
			end,
			'fallback',
		},
	},
	appearance = {
		use_nvim_cmp_as_default = true,
	}
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
vim.lsp.config('*', {
	capabilities = capabilities
})

vim.lsp.config('lua_ls',{
	cmd = {'lua-language-server'},
	filetypes = {'lua'},
	root_markers = { '.luarc.json', '.git' },
	settings = {
		Lua = {
			runtime = {version = 'LuaJIT'},
			diagnostics = {globals = {'vim'} },
		}
	},
	capabilities = capabilities,
})

vim.lsp.enable('lua_ls')

-- Detectar git automáticamente y guardar en mini.visits
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
    if git_root ~= "" then
      require("mini.visits").add_path(git_root, "project")
    end
  end,
})


