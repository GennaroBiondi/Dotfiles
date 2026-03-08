#!/usr/bin/env sh

if makoctl mode | grep -qx dnd; then
    makoctl mode -r dnd
    notify-send "Notifications enabled"
else
    makoctl mode -a dnd
    notify-send -t 2000 "Notifications disabled"
fi
