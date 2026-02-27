require("oil").setup({
	view_options = { 
		show_hidden = true
	}
})

vim.keymap.set("n", "<leader>e", function()
	vim.cmd("Oil")
end, {desc = "Open Oil"})
