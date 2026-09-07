hl.config({
	input = {
		kb_layout = "us,us",
		kb_variant = "intl,colemak",
		kb_options = "grp:win_space_toggle,caps:escape",

		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = true,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
