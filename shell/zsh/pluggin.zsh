#!/bin/sh

function load() {
	if [ -z $1 ]; then
		echo "Must supply an argument"
	else
		if [[ $1 == *\/* ]]; then
			name=$(echo $1 | cut -d '/' -f2)
			if [[ ! -e $ZSH_PLUGGIN/$1 ]]; then
				git ls-remote -q -h https://github.com/$1 > /dev/null
				if [ $? -eq 0 ]; then
					git clone -q https://github.com/$1 $ZSH_PLUGGIN$name 2>/dev/null
					source $ZSH_PLUGGIN$name/$name.zsh
				else
					echo "Pluggin not found. Check the name."
				fi
			else
				source $ZSH_PLUGGIN$name/$name.zsh
			fi
		else
			echo "'$1' must have the following form user/repo"
		fi
	fi
}
