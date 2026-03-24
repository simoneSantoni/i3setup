#!/bin/bash

# microphone.sh - Microphone mute toggle for Polybar (PipeWire)

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/colors.sh"

get_mute_status() {
  wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED
}

toggle() {
  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
}

display() {
  if get_mute_status; then
    echo "%{F${COLOR_DISABLED}}󰍭%{F-}"
  else
    echo "%{F${COLOR_PRIMARY}}󰍬%{F-}"
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
