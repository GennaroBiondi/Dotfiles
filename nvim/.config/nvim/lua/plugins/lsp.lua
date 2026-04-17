return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- local lspconfig = require("lspconfig")

			-- vim.lsp.config.lua_ls.setup({
			-- 	settings = {
			-- 		Lua = { diagnostics = { globals = { "vim" } } },
			-- 	},
			-- })
			vim.lsp.enable("lua_ls")

			vim.lsp.config("lua_ls", {
				workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			})

			vim.lsp.config("luau_ls", {
				types = {
					definitionFiles = { "/home/Gennaro/Downloads/globalTypes.None.d.luau" },
				},
			})
		end,
	},
}
