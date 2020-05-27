#!/bin/sh

(rm /tmp/.xmonad-workspace-log; mkfifo /tmp/.xmonad-workspace-log) &

# Configure X
xsetroot -cursor_name left_ptr &
xrdb -merge ~/.Xresources &
xmodmap ~/.Xmodmap

# Set a wallpaper
# feh --bg-fill ~/.wallpaper.jpg &
feh --randomize --bg-fill --no-fehbg ~/wallpapers
