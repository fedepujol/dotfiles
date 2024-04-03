local wezterm = require("wezterm")
local colors = require("colors")

local GLYPH_SEMI_CIRCLE_LEFT = ""
local GLYPH_SEMI_CIRCLE_RIGHT = ""
local GLYPH_CIRCLE = ""
local M = {}

local __cells__ = {}

local _set_process_name = function(s)
	local a = string.gsub(s, "(.*[/\\])(.*)", "%2")
	return a:gsub("%.exe$", "")
end

---@param fg string
---@param bg string
---@param attribute table
---@param text string
local _push = function(bg, fg, attribute, text)
	table.insert(__cells__, { Background = { Color = bg } })
	table.insert(__cells__, { Foreground = { Color = fg } })
	table.insert(__cells__, { Attribute = attribute })
	table.insert(__cells__, { Text = text })
end

M.setup = function()
	wezterm.on("format-tab-title", function(tab, _, _, _, hover, _)
		__cells__ = {}

		local bg
		local fg
		local glyph_fg = colors.tab_bar.background

		local process_name = _set_process_name(tab.active_pane.foreground_process_name)

		if tab.is_active then
			bg = colors.tab_bar.active_tab.bg_color
			fg = colors.tab_bar.active_tab.fg_color
		elseif hover then
			bg = colors.tab_bar.inactive_tab_hover.bg_color
			fg = colors.tab_bar.inactive_tab_hover.fg_color
		else
			bg = colors.tab_bar.inactive_tab.bg_color
			fg = colors.tab_bar.inactive_tab.fg_color
		end

		local has_unseen_output = false
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				has_unseen_output = true
				break
			end
		end

		-- Left semi-circle
		_push(glyph_fg, bg, { Intensity = "Bold" }, GLYPH_SEMI_CIRCLE_LEFT)

		-- Title
		_push(bg, fg, { Intensity = "Bold" }, " " .. process_name)

		-- Unseen output alert
		if has_unseen_output then
			_push(bg, "#FFA066", { Intensity = "Bold" }, " " .. GLYPH_CIRCLE)
		end

		-- Right padding
		_push(bg, fg, { Intensity = "Bold" }, " ")

		-- Right semi-circle
		_push(glyph_fg, bg, { Intensity = "Bold" }, GLYPH_SEMI_CIRCLE_RIGHT)

		return __cells__
	end)
end

return M
