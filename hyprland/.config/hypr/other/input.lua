hl.config({
	input = {
		kb_layout  = "it",
		kb_variant = "",
		kb_model   = "",
		kb_options = "",
		kb_rules   = "",

		repeat_delay = 250,

		follow_mouse = 1,

		sensitivity    = 0,
		force_no_accel = true,

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.device({
	name        = "epic-mouse-v1",
	sensitivity = -0.5,
	scroll_factor = 5.0,
})
