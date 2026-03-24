#!/bin/bash

# colors.sh - Shared color definitions for polybar scripts
# Sources the current theme (light/dark) and exports color variables

THEME_FILE="/tmp/polybar_theme"

_current_theme() {
  if [[ -f "$THEME_FILE" ]]; then
    cat "$THEME_FILE"
  else
    echo "dark"
  fi
}

if [[ "$(_current_theme)" == "light" ]]; then
  COLOR_PRIMARY="#0969da"
  COLOR_SECONDARY="#0550ae"
  COLOR_DISABLED="#8c959f"
  COLOR_ALERT="#cf222e"
else
  COLOR_PRIMARY="#2f81f7"
  COLOR_SECONDARY="#1f6feb"
  COLOR_DISABLED="#484f58"
  COLOR_ALERT="#f85149"
fi
