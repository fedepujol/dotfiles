local wezterm = require("wezterm")
local colors = require("colors")
local settings = require("settings")

require("events.format-tab-title")
require("events.gui-startup")

return {
	-- Font
	font = wezterm.font_with_fallback({
		"FiraCode Nerd Font",
		"JetBrains Mono",
	}),
	font_size = 11,
	warn_about_missing_glyphs = false,

	-- Keys
	keys = settings.keys,

	-- Tabs
	hide_tab_bar_if_only_one_tab = false,
	show_new_tab_button_in_tab_bar = true,
	show_tab_index_in_tab_bar = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	tab_max_width = 60,

	-- Updates
	show_update_window = false,
	check_for_updates = false,

	-- Other Config
	exit_behavior = "Close",
	audible_bell = "Disabled",
	automatically_reload_config = true,
	enable_scroll_bar = true,

	-- Shell
	launch_menu = settings.launch.launch_menu,
	default_prog = settings.launch.shell,

	-- Theme
	colors = colors,
}
