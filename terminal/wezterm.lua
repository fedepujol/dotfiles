-- Wezterm Config
local wezterm = require('wezterm')

local colors = {
	foreground = '#E5F3FA',
	background = '#131B25',
	split = '#2D4F67',
	red = "#E82424",
	red2 = "#FF5D62",
	green = "#95C561",
	cyan = "#71BAF2",
	pink = "#ECB2F0",
	teal = "#4DB5BD",
	teal2 = "#2DF4C0",
	grey = "#B0BEC5",
	grey2 = "#7C8083",
	blue = "#1C4474",
	purple = "#D67AD2",
	yellow = "#FFCC00",
	yellow2 = "#F9E2AF",
	black = "#1A1A1A",
	black2 = "#3A3432",
}

local process_name = function(tab)
	local icon = {
		["zsh"] = {
			{ Foreground = { Color = colors.yellow2 } },
			{ Text = wezterm.nerdfonts.dev_terminal },
		},
		["nvim"] = {
			{ Foreground = { Color = colors.green }},
			{ Text = wezterm.nerdfonts.custom_vim },
		},
		["git"] = {
			{ Text = wezterm.nerdfonts.dev_git },
		},
		["lazygit"] = {
			{ Text = wezterm.nerdfonts.dev_git },
		}
	}

	local name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
	return wezterm.format(icon[name] or {
		{ Forground = { Color = colors.split } },
		{ Text = string.format("[%s]", name) }
	})
end

wezterm.on("format-tab-title", function(tab)
	return wezterm.format({
		{ Attribute = { Intensity = "Half" } },
		{ Text = string.format(" %s ", tab.tab_index + 1) },
		"ResetAttributes",
		{ Text = process_name(tab) },
		{ Text = " |" }
	})
end)

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
	show_new_tab_button_in_tab_bar = false,
	warn_about_missing_glyphs = false,
	colors = {
		foreground = colors.foreground,
		background = colors.background,
		split = colors.split,
		ansi = {
			colors.black,
			colors.red,
			colors.green,
			colors.yellow2,
			colors.cyan,
			colors.pink,
			colors.teal,
			colors.grey,
		},
		brights = {
			colors.grey2,
			colors.red2,
			colors.black2,
			colors.yellow,
			colors.blue,
			colors.purple,
			colors.teal2,
			colors.foreground,
		}
	}
}
