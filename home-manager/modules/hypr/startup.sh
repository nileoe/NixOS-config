#!/usr/bin/env bash
#
# initializing wallpaper daemon
swww init &

# setting wallpaper
swww img ~/Pictures/wallpapers/fancy_moon_paint.jpg &

nm-applet --indicator &

waybar &

mako &
