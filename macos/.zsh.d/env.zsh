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

export FZF_DEFAULT_OPTS='
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

export COLORTERM="truecolor"
