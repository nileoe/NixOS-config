#!/usr/bin/env bash

exec-once = dbus-update-activation-environment --systemd --all debug:disable_logs = false

nm-applet --indicator &

waybar &

mako &

exec-once = hypridle
