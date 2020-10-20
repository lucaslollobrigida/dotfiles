#!/usr/bin/env zsh

# setopt correct
unsetopt correct_all
setopt noflowcontrol

# User configuration
# bindkey -v
export KEYTIMEOUT=1

export MANPATH="/usr/local/man:$MANPATH"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export TERMINFO=~/.terminfo

export EDITOR=nvim

# Compilation flags
export ARCHFLAGS="-arch x86_64"

export GPG_TTY=$(tty)
