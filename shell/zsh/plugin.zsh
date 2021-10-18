#!/bin/sh

# Name: Load 
# Desc: Checks whether a plugin exists or not. 
# If it doesn't exists then tries to download
# from GitHub and source it.
function load() {
	if [ -z $1 ]; then
		echo "Must supply an argument"
	else
		if [[ $1 == *\/* ]]; then
			name=$(echo $1 | cut -d '/' -f2)
			if [[ ! -d $ZSH_PLUGIN/$name ]]; then
				git ls-remote -q -h https://github.com/$1 > /dev/null
				if [ $? -eq 0 ]; then
					git clone -q https://github.com/$1 $ZSH_PLUGIN$name 2>/dev/null
					source $ZSH_PLUGIN$name/$name.zsh
				else
					echo "Plugin not found. Check the name."
				fi
			else
				source $ZSH_PLUGIN$name/$name.zsh
			fi
		else
			echo "'$1' must have the following form user/repo"
		fi
	fi
}
