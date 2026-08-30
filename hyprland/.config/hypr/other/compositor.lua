hl.config({
	general = {
		gaps_in          = 5,
		gaps_out         = 5,

		border_size      = 2,

		col              = {
			active_border   = "rgba(FF0000FF)",
			inactive_border = "rgba(ff000055)",
		},

		resize_on_border = false,
		allow_tearing    = false,
		layout           = "dwindle",
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		force_default_wallpaper    = false,
		initial_workspace_tracking = 2,
		disable_hyprland_logo      = true,
	},
})
