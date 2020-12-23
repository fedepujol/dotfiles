# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt nomatch
unsetopt autocd beep extendedglob notify

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/fedepujol/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

### Set Vi mode in Zsh ###
bindkey -v

# Prompt
PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %# '

### Aliases

# File System Aliases
 alias ..='cd ..'
 alias ...='cd ../../'
 alias 3..='cd ../../../'
 alias u-conf='cd /home/fedepujol/.config'
 alias u-docs='cd /home/fedepujol/Documents'
 alias u-dwnl='cd /home/fedepujol/Downloads'
 alias logs='cd /var/log'

# Command Aliases
 alias mv='mv -i'
 alias cp='cp -i'
 alias rm='rm -i'
 alias grep='grep --color=always'
 alias cat='bat'
 alias ls='exa -la --git'
 alias l='ls -alh --color=always'
 alias ll='exa -l --git'
 alias ubb='bleachbit -c system.localizations system.cache system.tmp system.trash'
 alias subb='sudo bleachbit -c system.rotated_logs system.localizations system.cache system.tmp system.trash'
 alias nnn='nnn -d -U -H'

# Package Aliases
 alias pinstall='sudo pacman -Syu'
 alias psearch='sudo pacman -Ss'
 alias premove='sudo pacman -Runs'
 alias orphans='sudo pacman -Qtd'
 alias aurfind='yay -Ss'
 alias aurinst='yay -Syu'

# Config Aliases
 alias shortcuts='cat /home/fedepujol/.config/sxhkd/sxhkdrc'
 alias aliases='vim /home/fedepujol/.zshrc'
 alias vim-conf='vim /home/fedepujol/.vimrc'

# Services Aliases
 alias systat='sudo systemctl status'
 alias systop='sudo systemctl stop'
 alias sysbeg='sudo systemctl start'
 alias sysena='sudo systemctl enable'
 alias sysdis='sudo systemctl disable'
 alias syfail='sudo systemctl --state=failed'
