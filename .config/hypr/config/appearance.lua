hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 2,
		border_size = 2,
		layout = "master",
		resize_on_border = false,
		allow_tearing = false,

		col = {
			active_border = "rgba(33ccffee)",
			inactive_border = "rgba(595959aa)",
		},
	},

	decoration = {
		rounding = 2,
		active_opacity = 1.0,
		inactive_opacity = 0.7,

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
		bezier = {
			myBezier = { 0.05, 0.9, 0.1, 1.05 },
		},
	},
})
