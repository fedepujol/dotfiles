local utils = require("utils")

local shell = {}
local launch_menu = {}

if utils.is_windows then
	local bash = { os.getenv("LOCALAPPDATA") .. "/programs/Git/bin/bash.exe" }
	launch_menu = {
		{
			label = "Git Bash",
			args = bash,
		},
		{ label = "PowerShell", args = { "powershell", "-NoLogo" } },
		{ label = "Command Prompt", args = { "cmd" } },
	}
	shell = bash
elseif utils.is_linux then
	launch_menu = {
		{ label = "ZSh", args = { "zsh" } },
		{ label = "Bash", args = { "bash" } },
	}
	shell = { "zsh" }
end

return {
	launch_menu = launch_menu,
	shell = shell,
}
