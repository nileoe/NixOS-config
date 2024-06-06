#!/usr/bin/env bash

swww-daemon &
swww img /home/nileoe/Pictures/wallpapers/dreamy_blue_moon.png && startWpRotation /home/nileoe/Pictures/wallpapers/ &

nm-applet --indicator &

waybar &

mako &
