#!/usr/bin/env bash

notification_format="Disable"

if makoctl mode | grep -qx dnd; then
    notification_format="Enable"
fi

option=$(printf "Shutdown\nReboot\nLogout\n$notification_format notifications" | wofi --dmenu)
if [ "$option" = "Shutdown" ]; then
    systemctl poweroff
elif [ "$option" = "Reboot" ]; then
    systemctl reboot
elif [ "$option" = "Logout" ]; then
    hyprctl dispatch exit
elif [ "$option" = "$notification_format notifications" ]; then
    . ~/.local/bin/toggle-mako.sh
fi
