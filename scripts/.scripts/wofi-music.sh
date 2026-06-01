#!/usr/bin/env sh
audio_paused=$(playerctl status 2>/dev/null)
case "$audio_paused" in
    Playing) label=" Pause media" ;;
    Paused)  label=" Play media"  ;;
    *)       label=" Play media"  ;;
esac

choice=$(printf '%s\n' "$label" "󰒭 Next track" "󰒮 Previous track" | wofi --dmenu --sort-order alphabetical)

if [ "$choice" = "$label" ]; then
    playerctl play-pause
elif [ "$choice" = "󰒭 Next track" ]; then
    playerctl next
elif [ "$choice" = "󰒮 Previous track" ]; then
    playerctl previous
fi
