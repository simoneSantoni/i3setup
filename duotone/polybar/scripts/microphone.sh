#!/bin/bash

# microphone.sh - Microphone mute toggle for Polybar (PipeWire)

get_mute_status() {
  wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED
}

toggle() {
  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
}

display() {
  if get_mute_status; then
    echo "%{F#5a6d6a}󰍭%{F-}"  # Muted (disabled color)
  else
    echo "%{F#00943e}󰍬%{F-}"  # Active (primary color)
  fi
}

case "$1" in
  --toggle)
    toggle
    ;;
  --status)
    get_mute_status && echo "muted" || echo "unmuted"
    ;;
  *)
    display
    ;;
esac

exit 0
