#!/usr/bin/env zsh

# setopt correct
unsetopt correct_all
setopt noflowcontrol

path=(
    /usr/local/bin
    /usr/local/opt/grep/libexec/gnubin
    $HOME/.local/bin
    $HOME/bin
    $HOME/Library/Python/3.7/bin/
    /usr/local/lib/python3.7/site-packages
    $HOME/.emacs.d/bin/
    /Library/Java/JavaVirtualMachines/graalvm-ce-java8-20.0.0/Contents/Home/bin
    $path
)

# Path to your oh-my-zsh installation.
if [[ ! -v ZSH ]]; then
# export ZSH=`nix eval nixpkgs.oh-my-zsh.outPath --raw`/share/oh-my-zsh/
  export ZSH="$HOME/.oh-my-zsh"
fi

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

export EDITOR=nvim

# Compilation flags
export ARCHFLAGS="-arch x86_64"

export GPG_TTY=$(tty)
