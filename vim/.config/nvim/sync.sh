#!/usr/bin/env bash

set -euo pipefail

CACHE="$XDG_CACHE_HOME/vim"
DATA="$XDG_DATA_HOME/vim"
CONFIG="$XDG_CONFIG_HOME/nvim"

mkdir -p "$CACHE/undo" "$CACHE/backup" "$CACHE/swap"
mkdir -p "$DATA/spell"

nvim +PlugSnapshot! "$CONFIG/snapshot.vim" +PlugUpgrade +PlugClean! +PlugUpdate +qa
nvim +UpdateRemotePlugins +qa
