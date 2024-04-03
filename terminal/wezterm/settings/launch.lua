local utils = require("utils")

local shell = {}
local launch_menu = {}

if utils.is_windows then
	launch_menu = {
		{ label = "PowerShell", args = { "powershell", "-NoLogo" } },
		{ label = "Command Prompt", args = { "cmd" } },
		{
			label = "Git Bash",
			args = { os.getenv("LOCALAPPDATA") .. "/programs/Git/bin/bash.exe" },
		},
	}
	shell = { os.getenv("LOCALAPPDATA") .. "/programs/Git/bin/bash.exe" }
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
