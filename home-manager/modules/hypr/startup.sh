#!/usr/bin/env bash

swww-daemon &

startWpRotation /home/nileoe/Pictures/wallpapers/ &

nm-applet --indicator &

waybar &

mako &
