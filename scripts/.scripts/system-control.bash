#!/usr/bin/env bash

# Dynamic label for Mako notifications
if makoctl mode | grep -qx dnd; then
    notification_format="Enable"
else
    notification_format="Disable"
fi

# Dynamic label for Waybar
if pgrep -x "waybar" > /dev/null; then
    waybar_state="Hide"
else
    waybar_state="Show"
fi

# Build menu with wofi
option=$(printf "⏻ Shutdown\n󱥸 Reboot\n󰀄 Logout\n %s Notifications\n %s Waybar" "$notification_format" "$waybar_state" | wofi --sort-order=no_sort --dmenu --cache-file /dev/null)

# Handle selections
case "$option" in
    "⏻ Shutdown")
        systemctl poweroff
        ;;
    "󱥸 Reboot")
        systemctl reboot
        ;;
    "󰀄 Logout")
        hyprctl dispatch exit
        ;;
    " $notification_format Notifications")
        bash ~/.scripts/toggle-mako.sh
        ;;
    " $waybar_state Waybar")
        if pgrep -x "waybar" > /dev/null; then
            pkill waybar
        else
            waybar & disown
        fi
        ;;
esac
