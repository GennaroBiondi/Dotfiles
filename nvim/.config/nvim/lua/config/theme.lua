local M = {}

function M.set(name)
	vim.cmd.colorscheme(name)
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
	-- Persist to a file
	local f = io.open(vim.fn.stdpath("data") .. "/theme", "w")
	if f then
		f:write(name)
		f:close()
	end
end

function M.load()
	local f = io.open(vim.fn.stdpath("data") .. "/theme", "r")
	local name = f and f:read("*a") or "lackluster"
	if f then f:close() end
	pcall(M.set, name)
end

return M
