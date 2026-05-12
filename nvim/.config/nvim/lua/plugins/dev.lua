return {
	{
		dir = "~/.nvim_plugins/presentr",
		config = function()
			require("presentr").setup()
		end,
	},
	{
		dir = "~/.nvim_plugins/caser/",
		config = function()
			require("caser").setup()
		end,
	},
}
