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
 alias u-conf='cd ~/.config'
 alias u-docs='cd ~/Documents'
 alias u-dwnl='cd ~/Downloads'
 alias workspace='cd ~/workspace'
 alias logs='cd /var/log'

# Command Aliases
 alias mv='mv -i'
 alias cp='cp -i'
 alias rm='rm -i'
 alias grep='grep --color=always'
 alias lx='exa -la --group-directories-first --git'
 alias l='ls -alh --color=always'
 alias ll='ls -a --group-directories-first --color=always'
 alias bbp='bleachbit -p system.tmp system.cache system.trash system.localizations vim.history firefox.backup firefox.cache firefox.cookies firefox.crash_reports firefox.dom firefox.forms firefox.passwords firefox.session_restore firefox.site_preferences firefox.url_history firefox.vacuum bash.history'
 alias bbpr='sudo bleachbit -p system.tmp system.cache system.trash system.localizations system.rotated_logs system.clipboard vim.history bash.history'
 alias bbu='bleachbit -c system.tmp system.cache system.trash system.localizations vim.history firefox.backup firefox.cache firefox.cookies firefox.crash_reports firefox.dom firefox.forms firefox.passwords firefox.session_restore firefox.site_preferences firefox.url_history firefox.vacuum bash.history'
 alias bbr='sudo bleachbit -c system.tmp system.cache system.trash system.localizations system.rotated_logs system.clipboard vim.history bash.history'
 alias nnn='nnn -d -U -H'

# Package Aliases
 alias pinstall='sudo pacman -Syu'
 alias psearch='sudo pacman -Ss'
 alias premove='sudo pacman -Runs'
 alias orphans='sudo pacman -Qtd'
 alias aurfind='yay -Ss'
 alias aurinst='yay -Syu'

# Config Aliases
 alias shortcuts='nvim ~/.config/sxhkd/sxhkdrc'
 alias aliases='nvim ~/.zshrc'
 alias nvim-conf='nvim ~/.conf/nvim'

# Services Aliases
 alias systat='sudo systemctl status'
 alias systop='sudo systemctl stop'
 alias sysbeg='sudo systemctl start'
 alias sysena='sudo systemctl enable'
 alias sysdis='sudo systemctl disable'
 alias syfail='sudo systemctl --state=failed'

# Source files
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

