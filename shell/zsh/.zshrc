# Enviroment Variables
# Defaults in case they're not set up
if [[ -z "$XDG_DATA_HOME" ]]; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi

if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -z "$XDG_CACHE_HOME" ]]; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi

if [[ -z "$ZSH_PLUGIN" ]]; then
	export ZSH_PLUGIN="$XDG_CONFIG_HOME/zsh/plugins/"
fi

# Set editor to NeoVim
export EDITOR='nvim'

# Define zsh directory
export ZSH_HOME="$XDG_CONFIG_HOME/zsh"

# Source configuration files
# functions.zsh -> Common functions
# alias.zsh -> Usefull aliases
[ -f $ZSH_HOME/functions.zsh ] && source $ZSH_HOME/functions.zsh
[ -f $ZSH_HOME/alias.zsh ] && source $ZSH_HOME/alias.zsh
[ -f $ZSH_HOME/plugin.zsh ] && source $ZSH_HOME/plugin.zsh

# ZSh Config

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt histignorealldups    # Subsitute commands in the prompt
setopt sharehistory         # Share history with other shells
setopt nonomatch            # Avoid zsh no matches found
setopt appendhistory        # Append history list to history file
setopt hist_reduce_blanks   # Remove blank lines from history
setopt hist_ignore_all_dups # Remove all duplicates from history
setopt nobeep               # Avoid beeping
setopt extended_glob        # Extended globbing
setopt extended_history     #
setopt notify               # Report the status of background jobs
setopt autocd               # Change to directory without "cd"
setopt longlistjobs         # Display PID when suspending processes
setopt hash_list_all        # When command completion is attempted, make sure the entire command path is hashed first.
setopt completeinword       # Complete at any position of the line
setopt auto_param_slash     # Append a slash if complettion target was a directory

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

# Pluggins
load 'zsh-users/zsh-syntax-highlighting'
