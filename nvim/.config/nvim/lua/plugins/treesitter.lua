
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    local ok, ts = pcall(require, "nvim-treesitter")
    if not ok then
      vim.notify("Treesitter no instalado", vim.log.levels.WARN)
      return
    end



	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.mips = {
		install_info = {
			url = "https://github.com/omeyenburg/tree-sitter-mips",
			files = { "src/parser.c" },
			branch = "main",
			generate_requires_npm = false,
			requires_generate_from_grammar = false,
		},
		filetype = "asm",
	}
	used_by = { "asm" }
	require("nvim-treesitter.configs").setup({
		ensure_installed = {"lua", "vim", "mips" },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		auto_install = true,
	})

	end
})

