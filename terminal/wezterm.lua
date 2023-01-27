-- Wezterm Config
local wezterm = require('wezterm')

return {
	font = wezterm.font_with_fallback({
		'FiraCode Nerd Font',
		'JetBrains Mono'
	}),
	font_size = 10,
	audible_bell = 'Disabled',
	automatically_reload_config = true,
	check_for_updates = false,
	hide_tab_bar_if_only_one_tab = true,
	colors = {
		foreground = '#E5F3FA',
		background = '#131B25',
		split = '#2D4F67',
		ansi = {
			"#1A1A1A",
			"#E82424",
			"#95C561",
			"#F9E2AF",
			"#71BAF2",
			"#ECB2F0",
			"#4DB5BD",
			"#B0BEC5"
		},
		brights = {
			"#7C8083",
			"#FF5D62",
			"#3a3432",
			"#FFCC00",
			"#1C4474",
			"#D67AD2",
			"#2DF4C0",
			"#E5F3FA"
		}
	}
}
