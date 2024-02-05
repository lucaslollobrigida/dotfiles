#!/usr/bin/env bash

primary_monitor=$(xrandr | grep ' connected primary' | cut -d' ' -f1 | head)
secondary_monitor=$(xrandr | grep ' connected' | cut -d' ' -f1 | tail -1)
xrandr_args=("--auto --output $primary_monitor --primary")
[[ ! -z $secondary_monitor ]] && xrandr_args+=("--output $secondary_monitor --right-of $primary_monitor")

echo "xrandr ${xrandr_args[@]} &"

xrandr ${xrandr_args[@]} &
