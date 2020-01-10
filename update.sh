#!/usr/bin/env bash

DOT_PATH="$HOME/.dotfiles/"

update_dotfiles() {
	git pull --recurse-submodules
	git submodule update --init --recursive --remote
}

if [ "$PWD" == $DOT_PATH ]; then
	update_dotfiles
else
	(cd $DOT_PATH && update_dotfiles)
fi
