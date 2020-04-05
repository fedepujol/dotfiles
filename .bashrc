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
export VISUAL="nano"
