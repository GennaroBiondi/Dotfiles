#!/usr/bin/env bash

notification_format="Disable"

if makoctl mode | grep -qx dnd; then
    notification_format="Enable"
fi

option=$(printf "⏻ Shutdown\n󱥸 Reboot\n󰀄 Logout\n $notification_format Notifications\n Restart Waybar" | wofi --sort-order=no_sort --dmenu --cache-file /dev/null)
if [ "$option" = "⏻ Shutdown" ]; then
    systemctl poweroff
elif [ "$option" = "󱥸 Reboot" ]; then
    systemctl reboot
elif [ "$option" = "󰀄 Logout" ]; then
    hyprctl dispatch exit
elif [ "$option" = " $notification_format Notifications" ]; then
	. ~/.scripts/toggle-mako.sh
elif [ "$option" = " Restart Waybar" ]; then
	pkill waybar
	waybar & disown
fi
