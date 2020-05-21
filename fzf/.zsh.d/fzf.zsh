#!/usr/bin/env zsh
 
path=(
    $HOME/.fzf/bin/
    $path
)

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi
