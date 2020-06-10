#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Para uso con LemonBar
#export PANEL_INFO=/tmp/panel-fifo
#export PATH=$PATH:/home/fedepujol/Documents/panel

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export PATH="/usr/lib/ccache/bin:$PATH"
export MAKEFLAGS="-j5 -l4"
export VISUAL="vim"

# Useful Aliases

# Dir Navigation
alias ls="exa -la --git"
alias ll="exa -l --git"
alias ..="cd .."

# Configs
alias u-conf="cd $HOME/.config"
alias u-opt-conf="cd /etc/optimus-manager/"

# Dirs
alias u-wrk="cd $HOME/workspace"
alias u-dwl="cd $HOME/Downloads"
alias u-doc="cd $HOME/Documents"

# Pacman
alias pinstall="sudo pacman -Syu"
alias premove="sudo pacman -Runs"
alias psearch="sudo pacman -Ss"

# AUR
alias aurinst="yay -Syu"
alias aurfind="yay -Ss"

# Logs
alias dirlog="cd /var/log/"
alias Xerrors="cat /var/log/Xorg.0.log | grep EE"
alias Xwarns="cat /var/log/Xorg.0.log | grep WW"
alias Xinfo="cat /var/log/Xorg.0.log | grep II"

# Utils
alias cpall="cp -r"
