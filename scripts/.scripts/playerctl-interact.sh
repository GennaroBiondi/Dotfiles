#!/usr/bin/env sh

audio_paused=$(playerctl status 2>/dev/null)
case "$audio_paused" in
    Playing) label=" Pause media" ;;
    Paused)  label=" Play media"  ;;
    *)       label=" Play media"  ;;
esac

mute_status=$(pactl get-sink-mute @DEFAULT_SINK@)
case "$mute_status" in
    *yes*) mute_label="󰕾 Unmute audio" ;;
    *)     mute_label="󰖁 Mute audio"   ;;
esac

choice=$(printf '%s\n' "$label" "󰒭 Next track" "󰒮 Previous track" "$mute_label" | wofi --dmenu --sort-order alphabetical)

if [ "$choice" = "$label" ]; then
    playerctl play-pause
elif [ "$choice" = "󰒭 Next track" ]; then
    playerctl next
elif [ "$choice" = "󰒮 Previous track" ]; then
    playerctl previous
elif [ "$choice" = "$mute_label" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
fi
