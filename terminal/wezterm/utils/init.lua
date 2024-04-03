local wezterm = require("wezterm")

---@param str string
---@param pattern string
---@return boolean
local function contains(str, pattern)
	return string.find(str, pattern) ~= nil
end

local is_windows = contains(wezterm.target_triple, "windows")
local is_linux = contains(wezterm.target_triple, "linux")
local is_apple = contains(wezterm.target_triple, "apple")

return {
	current_os = is_apple and "mac" or is_linux and "linux" or is_windows and "windows" or "unknown",
	is_apple = is_apple,
	is_linux = is_linux,
	is_windows = is_windows,
}
