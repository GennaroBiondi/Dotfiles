vim.api.nvim_create_user_command("Format", "normal gg=G", {})

vim.api.nvim_create_user_command("Theme", function(opts)
	require("config.theme").set(opts.args)
end, { nargs = 1, complete = "color" })
