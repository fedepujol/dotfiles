#!/bin/sh

# Extract 
# Desc: Takes a compress file and it tries to extract 
# its content
# Input: Compress file
# Output: Extracted data in new folder
# Error: When type is not on the list
function extract() {
	if [ -z $1 ]; then
		echo "Must supply an argument!"
	else
		echo Extracting $1 ...
		if [ -f $1 ]; then
			case $1 in
				*.tar.bz2)  tar xjf $1    ;;
				*.tar.gz)   tar xzf $1    ;;
				*.bz2)      bunzip2 $1    ;;
				*.rar)      unrar x $1    ;;
				*.gz)       gunzip $1     ;;
				*.tar)      tar xf $1     ;;
				*.tbz2)     tar xjf $1    ;;
				*.tbz)      tar -xjvf $1  ;;
				*.tgz)      tar xzf $1    ;;
				*.zip)      7z x $1       ;;
				*.7z)       7z x $1       ;;
				*)          echo "Unknown file type: '$1'";;
			esac
		else
			echo "'$1' is not a valid file"
		fi
	fi
}

function compress() {
	echo Compressing $1 ...
	if [ $2 ]; then
		case $2 in
			tbz) 	tar cjvf $1.tar.bz2      ;;
			tgz) 	tar czvf $1.tar.gz       ;;
			tar) 	tar cpvf $1.tar          ;;
			bz2) 	bzip $1                  ;;
			gz) 	gzip -c -9 -n $1 > $1.gz ;;
			zip) 	zip -r $1.zip            ;;
			7z) 	7z a $1.7z               ;;
			*) 		echo "'$2' Unknown compress algorithm";;
		esac
	else
		echo "'$1' not a valid file"
	fi
}

function pluggin() {
	
}

function fhist() {
	cat $HOME'/.histfile' | awk -F ';' '{print $2}' | fzf -e --layout=reverse --height=20
}

function fsysctl() {
	systemctl | grep loaded | grep -v LOAD | grep -v units | cut -d ' ' -f 3 | fzf --ansi --layout=reverse --border=rounded --preview='SYSTEMD_COLORS=1 systemctl status {1} --no-pager'
}
