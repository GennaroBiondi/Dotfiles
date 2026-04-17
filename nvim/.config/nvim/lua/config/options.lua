vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Show line numbers relative to current line
vim.o.cursorline = true -- Highlight the cursor current line
vim.opt.tabstop = 4 -- Display tabs as 4 columns wide
vim.opt.shiftwidth = 4 -- Already correct

vim.api.nvim_set_option("clipboard", "unnamedplus") -- Set clipboard to global

vim.diagnostic.config({
	virtual_text = true,
})
