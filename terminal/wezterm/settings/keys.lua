local wezterm = require("wezterm")
local utils = require("utils")

local act = wezterm.action
local mod = {}

if utils.is_windows then
	mod.SUPER = "CTRL|SHIFT"
	mod.SUPER_REV = "CTRL|SHIFT|ALT"
	mod.NONE = "NONE"
end

return {
	{ key = "F2", mods = mod.NONE, action = act.ActivateCommandPalette },
	{ key = "F3", mods = mod.SUPER, action = act.ShowLauncher },
	{ key = "F4", mods = mod.SUPER, action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },

	-- New Tab to home dir
	{ key = "t", mods = mod.SUPER, action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir }) },

	-- Edit tab title
	{
		key = "e",
		mods = mod.SUPER,
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- Line will be `nil` when hitting escape
				-- `empty` when hitting enter
				-- Text written
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}
