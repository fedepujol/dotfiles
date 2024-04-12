local wezterm = require("wezterm")
local colors = require("colors")

local HALF_CIRCLE_LEFT = wezterm.nerdfonts.ple_left_half_circle_thick
local HALF_CIRCLE_RIGHT = wezterm.nerdfonts.ple_right_half_circle_thick
local CIRCLE_FILLED = wezterm.nerdfonts.cod_circle_filled

local __cells__ = {}

---Returns the icon of the string passed
---@param name_to_find string
---@return string
local function find_icon(name_to_find)
	local icons = {
		["bash"] = wezterm.nerdfonts.cod_terminal_bash,
		["cmd"] = wezterm.nerdfonts.cod_terminal_cmd,
		["powershell"] = wezterm.nerdfonts.cod_terminal_powershell,
		["git"] = wezterm.nerdfonts.dev_git,
		["lazygit"] = wezterm.nerdfonts.dev_git,
		["nvim"] = wezterm.nerdfonts.linux_neovim,
		["mvn"] = wezterm.nerdfonts.seti_maven,
		["node"] = wezterm.nerdfonts.md_nodejs,
		["ngcc"] = wezterm.nerdfonts.md_angular,
	}

	return icons[name_to_find]
end

local function clean_string(some_string)
	return some_string:gsub("(.*[/\\])(.*)", "%2"):gsub("%.exe$", "")
end

local function basename(path)
	local trimmed_path = path:gsub("[/\\]*$", "") ---Remove trailing slashes from the path
	local index = trimmed_path:find("[^/\\]*$") ---Find the last occurrence of '/' in the path

	return index and trimmed_path:sub(index) or trimmed_path
end

---Given the executable name, it strips everything
---@param tab table
local function title_or_process_name(tab)
	local name = ""
	local title = tab.tab_title or ""
	local process_name = tab.active_pane.foreground_process_name or ""

	if title ~= "" or #title > 0 then
		name = title
	else
		if process_name:find("%-language%-server") then
			name = "nvim"
		else
			name = process_name
		end
	end

	return clean_string(name)
end

---Builds the title table
---@param fg string
---@param bg string
---@param attribute table
---@param text string
local function build_title(bg, fg, attribute, text)
	table.insert(__cells__, { Background = { Color = bg } })
	table.insert(__cells__, { Foreground = { Color = fg } })
	table.insert(__cells__, { Attribute = attribute })
	table.insert(__cells__, { Text = text })
end

wezterm.on("format-tab-title", function(tab, _, _, _, hover, _)
	__cells__ = {}

	local bg
	local fg
	local glyph_fg = colors.tab_bar.background

	local tab_title = title_or_process_name(tab)
	local cwd = basename(tab.active_pane.current_working_dir.file_path)
	local icon = find_icon(tab_title)

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
	build_title(glyph_fg, bg, { Intensity = "Bold" }, HALF_CIRCLE_LEFT)

	-- Icon
	build_title(bg, fg, { Intensity = "Bold" }, " " .. icon)

	-- Title
	build_title(bg, fg, { Intensity = "Bold" }, " " .. tab_title)

	-- CWD
	build_title(bg, fg, { Intensity = "Bold" }, " (" .. wezterm.nerdfonts.md_folder .. " " .. cwd:lower() .. ")")

	-- Unseen output alert
	if has_unseen_output then
		build_title(bg, colors.ansi[4], { Intensity = "Bold" }, " " .. CIRCLE_FILLED)
	end

	-- Right padding
	build_title(bg, fg, { Intensity = "Bold" }, " ")

	-- Right semi-circle
	build_title(glyph_fg, bg, { Intensity = "Bold" }, HALF_CIRCLE_RIGHT)

	return __cells__
end)
