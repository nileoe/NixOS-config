#!/usr/bin/env bash

swww-daemon &
swww img /home/nileoe/Pictures/wallpapers/dreamy_blue_moon.png &

nm-applet --indicator &

waybar &

mako &

/home/nileoe/scripts/bash_wallpaper_change.sh&
