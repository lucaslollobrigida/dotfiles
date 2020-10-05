#!/usr/bin/env zsh

# setopt correct
unsetopt correct_all
setopt noflowcontrol

path=(
    /usr/local/bin
    /usr/local/lib/python3.7/site-packages
    /usr/local/opt/grep/libexec/gnubin
    $HOME/.local/bin
    $HOME/bin
    $HOME/.emacs.d/bin
    $HOME/Library/Python/3.7/bin
    /usr/local/Cellar/neovim/0.4.4/bin/
    /usr/local/opt/openjdk/bin
    $path
)

# Path to your oh-my-zsh installation.
# ZPATH=`nix eval nixpkgs.oh-my-zsh.outPath`
export ZSH="$HOME/.oh-my-zsh"

# Default ENV variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_DIRS="/etc/xdg"

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
