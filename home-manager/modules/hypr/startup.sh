#!/usr/bin/env bash

swww-daemon &

sleep 1
startWpRotation /home/nileoe/Pictures/wallpapers/ &

nm-applet --indicator &

waybar &

mako &
