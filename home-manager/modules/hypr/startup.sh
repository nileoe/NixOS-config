#!/usr/bin/env bash

swww-daemon &

startWpRotation ${../../../data/wallpapers/selected} &

nm-applet --indicator &

waybar &

mako &
