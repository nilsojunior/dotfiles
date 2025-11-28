#!/bin/sh

case "$1" in
"volume-up")
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
    notify-send "Volume: ${volume}%" --expire-time 2000 --transient -h string:x-canonical-private-synchronous:volume_change
    ;;

"volume-down")
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
    notify-send "Volume: ${volume}%" --expire-time 2000 --transient -h string:x-canonical-private-synchronous:volume_change
    ;;

"volume-toggle")
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')

    if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "\[MUTED\]"; then
        notify-send "Sound Muted" --expire-time 2000 --transient -h string:x-canonical-private-synchronous:volume_toggle
    else
        notify-send "Sound Unmuted: ${volume}%" --expire-time 2000 --transient -h string:x-canonical-private-synchronous:volume_toggle
    fi
    ;;

"mic-toggle")
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2 * 100}')

    if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "\[MUTED\]"; then
        notify-send "Microphone Muted" --expire-time 2000 --transient -h string:x-canonical-private-synchronous:volume_toggle
    else
        notify-send "Microphone Unmuted: ${volume}%" --expire-time 2000 --transient -h string:x-canonical-private-synchronous:volume_toggle
    fi
    ;;
"brightness-up")
    brightnessctl s 10%+
    brightness=$(brightnessctl -m | cut -d, -f4 | tr -d '%')
    notify-send "Brightness: ${brightness}%" --expire-time 2000 --transient -h string:x-canonical-private-synchronous:brightness
    ;;
"brightness-down")
    brightnessctl s 10%-
    brightness=$(brightnessctl -m | cut -d, -f4 | tr -d '%')
    notify-send "Brightness: ${brightness}%" --expire-time 2000 --transient -h string:x-canonical-private-synchronous:brightness
    ;;
*) ;;
esac
