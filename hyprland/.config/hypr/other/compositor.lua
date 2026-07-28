hl.config({
	general = {
		gaps_in  = 5,
		gaps_out = 10,

		border_size = 2,

		col = {
			active_border   = "rgba(DEEEEDFF)",
			inactive_border = "rgba(708090FF)",
		},

		resize_on_border = false,
		allow_tearing    = false,
		layout           = "dwindle",
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		force_default_wallpaper = false,
		disable_hyprland_logo   = true,
	},
})
