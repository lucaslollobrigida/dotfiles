#!/usr/bin/env zsh

setopt correct
setopt noflowcontrol

path=(
    /usr/local/bin
    $HOME/.local/bin
    $HOME/bin
    $HOME/Library/Python/3.7/bin/
    $HOME/.emacs.d/bin/
    $path
)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# User configuration
# bindkey -v
export KEYTIMEOUT=1

export MANPATH="/usr/local/man:$MANPATH"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR=nvim

# Compilation flags
export ARCHFLAGS="-arch x86_64"


export GPG_TTY=$(tty)
export PINENTRY_USER_DATA="USE_CURSES=1"
