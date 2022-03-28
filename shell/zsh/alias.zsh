### Aliases

# File System Aliases
 alias ..='cd ..'
 alias ...='cd ../../'
 alias dotfiles='cd ~/workspace/dotfiles'
 alias diskusage='du -P -S -h | sort -n | tail -n 20'

# Sourcing Aliases
 alias srcz='source .zshrc'
 alias srcb='source .bashrc'

# Command Aliases
 alias mv='mv -i'
 alias cp='cp -i'
 alias rm='rm -i'
 alias df='df -h'
 alias grep='grep --color=always'
 alias lx='exa -la --group-directories-first --git'
 alias l='ls -alh --color=always'
 alias ll='ls -a --group-directories-first --color=always'
 alias bbu='bleachbit -c system.tmp system.cache system.trash system.localizations vim.history firefox.backup firefox.cache firefox.cookies firefox.crash_reports firefox.dom firefox.forms firefox.passwords firefox.session_restore firefox.site_preferences firefox.url_history firefox.vacuum bash.history'
 alias bbr='sudo bleachbit -c system.tmp system.cache system.trash system.localizations system.rotated_logs vim.history bash.history'
 alias ip='ip -c a'

# Package Aliases
# Pacman
 alias pacupdt='sudo pacman -Syu --noconfirm'
 alias pacinst='sudo pacman -S'
 alias pacfind='sudo pacman -Ss'
 alias pacclnc='sudo pacman -Sc'
 alias pacdlt='sudo pacman -Runs'
# Yay
 alias aurupd='yay -Sua --noconfirm'
 alias aurinst='yay -S'
 alias aurfind='yay -Ss'
 alias aurcln='yay -Sc'
# General
 alias orphans='sudo pacman -Qtdt'
 alias chkupdt='checkupdates'

# Config Aliases
 alias aliases='$EDITOR ~/.config/zsh/alias.zsh'
 alias nvim-conf='cd ~/.config/nvim && $EDITOR'

# BSPWM Aliases
 alias bspwm-conf='cd ~/.config/bspwm && $EDITOR bspwmrc'
 alias bspwm-keys='$EDITOR ~/.config/sxhkd/sxhkdrc'
 alias bspwm-bar='cd ~/.config/polybar && $EDITOR config.ini'

# XMonad Aliases
 alias xmonad-conf='cd ~/.xmonad && $EDITOR xmonad.hs'
 alias xmonad-bar='cd ~/.config/xmobar && $EDITOR .xmobarrc'

# Services Aliases
 alias systat='sudo systemctl status'
 alias systop='sudo systemctl stop'
 alias sysbeg='sudo systemctl start'
 alias sysena='sudo systemctl enable'
 alias sysdis='sudo systemctl disable'
 alias syfail='sudo systemctl --state=failed'
 alias sysres='sudo systemctl restart'

# Languages Aliases
 alias luamake=/home/fedepujol/.config/nvim/lua-language-server/3rd/luamake/compile/luamake
