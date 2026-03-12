#!/usr/bin/env sh

screenshot_mode=$(printf "Screenshot region\nScreenshot display" | wofi --dmenu --sort-order alphabetical)
[ -z "$screenshot_mode" ] && exit

screenshot_to=$(printf "Clipboard\nFilesystem" | wofi --dmenu --sort-order alphabetical)
[ -z "$screenshot_to" ] && exit

case "$screenshot_mode" in
    "Screenshot region")
        if [ "$screenshot_to" = "Clipboard" ]; then
            grim -g "$(slurp)" - | wl-copy
        else
            grim -g "$(slurp)" "$HOME/Temp/screenshot_$(date +%Y%m%d_%H%M%S).png"
        fi
        ;;
    "Screenshot display")
	sleep 1
        if [ "$screenshot_to" = "Clipboard" ]; then
            grim - | wl-copy
        else
            grim "$HOME/Temp/screenshot_$(date +%Y%m%d_%H%M%S).png"
        fi
	notify-send "Success!" "Screenshot successfully taken!"
        ;;
esac
