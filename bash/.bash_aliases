#!/usr/bin/env bash

alias vim='nvim'
alias python='python3'

alias bc='vim $HOME/.dotfiles/bash/.bashrc'
alias vc='vim $HOME/.dotfiles/vim/.config/nvim/init.vim'
alias load='source $HOME/.bashrc'
alias ip='ipconfig getifaddr en0'

alias grep='grep --color=auto'
alias la='ls -lAGh'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

DEV_PATH="$HOME/dev"
alias dev="cd $DEV_PATH"
alias cjs="cd $DEV_PATH/node"
alias cpy="cd $DEV_PATH/python"
alias csh="cd $DEV_PATH/shell"
alias cgo="cd $DEV_PATH/go"
alias ccj="cd $DEV_PATH/clojure"
