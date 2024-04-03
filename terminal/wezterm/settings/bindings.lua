local wezterm = require("wezterm")
local utils = require("utils")

local act = wezterm.action
local mod = {}

if utils.is_windows then
	mod.SUPER = "ALT"
	mod.SUPER_REV = "ALT|CTRL"
end

return {
	{ key = "F2", mods = "NONE", action = act.ActivateCommandPalette },
	{ key = "F3", mods = "NONE", action = act.ShowLauncher },
	{ key = "F4", mods = "NONE", action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },

	-- Panes --
	-- Split
	{
		key = [[\]],
		mods = mod.SUPER,
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = [[\]],
		mods = mod.SUPER_REV,
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- Close
	{ key = "w", mods = mod.SUPER, action = act.CloseCurrentPane({ confirm = false }) },
	-- Zoom
	{ key = "Enter", mods = mod.SUPER, action = act.TogglePaneZoomState },

	-- Navigation
	{ key = "k", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Down") },
	{ key = "h", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Right") },
	{
		key = "p",
		mods = mod.SUPER_REV,
		action = act.PaneSelect({ alphabet = "1234567890", mode = "SwapWithActiveKeepFocus" }),
	},
}
