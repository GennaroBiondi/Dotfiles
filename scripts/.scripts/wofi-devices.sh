#!/usr/bin/env sh
mute_status=$(pactl get-sink-mute @DEFAULT_SINK@)
case "$mute_status" in
    *yes*) mute_label="󰕾 Unmute audio" ;;
    *)     mute_label="󰖁 Mute audio"   ;;
esac

mic_mute_status=$(wpctl get-volume @DEFAULT_SOURCE@)
case "$mic_mute_status" in
    *MUTED*) mic_mute_label="󰍬 Unmute mic" ;;
    *)       mic_mute_label="󰍭 Mute mic"   ;;
esac

choice=$(printf '%s\n' "$mute_label" "$mic_mute_label" | wofi --dmenu --sort-order alphabetical)

if [ "$choice" = "$mute_label" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
elif [ "$choice" = "$mic_mute_label" ]; then
    wpctl set-mute @DEFAULT_SOURCE@ toggle
fi
