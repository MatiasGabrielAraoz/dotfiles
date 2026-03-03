
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

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
    if git_root ~= "" then
      require("mini.visits").add_path(git_root, "project")
    end
  end,
})


