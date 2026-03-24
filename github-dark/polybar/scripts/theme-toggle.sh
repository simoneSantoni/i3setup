#!/bin/bash

# theme-toggle.sh - Toggle between light and dark themes across all components

CONFIG_FILE="$HOME/.config/polybar/config.ini"
THEME_FILE="/tmp/polybar_theme"
ROFI_CONFIG="$HOME/.config/rofi/config.rasi"
ROFI_SHARED="$HOME/.config/rofi/launchers/type-3/shared/colors.rasi"
DUNST_FILE="$HOME/.config/dunst/dunstrc"

get_current_theme() {
  if [[ -f "$THEME_FILE" ]]; then
    cat "$THEME_FILE"
  else
    if grep -q "^background = #ffffff" "$CONFIG_FILE" 2>/dev/null; then
      echo "light"
    else
      echo "dark"
    fi
  fi
}

set_theme() {
  local theme="$1"

  if [[ "$theme" == "light" ]]; then
    local bg="#ffffff" bg_alt="#f6f8fa" fg="#1f2328"
    local primary="#0969da" secondary="#0550ae" alert="#cf222e" disabled="#8c959f"
    local dunst_bg="#ffffff" dunst_fg="#1f2328" dunst_frame="#0969da"
    local dunst_highlight="#0550ae" dunst_low_bg="#f6f8fa" dunst_low_frame="#d0d7de"
    local dunst_crit_fg="#cf222e" dunst_crit_frame="#cf222e" dunst_crit_highlight="#a40e26"
    local rofi_file="github-light"
  else
    local bg="#0d1117" bg_alt="#161b22" fg="#e6edf3"
    local primary="#2f81f7" secondary="#1f6feb" alert="#f85149" disabled="#484f58"
    local dunst_bg="#0d1117" dunst_fg="#e6edf3" dunst_frame="#2f81f7"
    local dunst_highlight="#58a6ff" dunst_low_bg="#161b22" dunst_low_frame="#30363d"
    local dunst_crit_fg="#ffa198" dunst_crit_frame="#f85149" dunst_crit_highlight="#ff7b72"
    local rofi_file="github-dark"
  fi

  # Polybar [colors] — single sed pass
  sed -i \
    -e "s/^background = .*/background = $bg/" \
    -e "s/^background-alt = .*/background-alt = $bg_alt/" \
    -e "s/^foreground = .*/foreground = $fg/" \
    -e "s/^primary = .*/primary = $primary/" \
    -e "s/^secondary = .*/secondary = $secondary/" \
    -e "s/^alert = .*/alert = $alert/" \
    -e "s/^disabled = .*/disabled = $disabled/" \
    "$CONFIG_FILE"

  # Rofi color scheme — update both import locations
  local rofi_import="@import \"~/.config/rofi/colors/${rofi_file}.rasi\""
  if [[ -f "$ROFI_SHARED" ]]; then
    sed -i "s|@import.*colors/github-.*\.rasi.*|${rofi_import}|" "$ROFI_SHARED"
  fi
  if [[ -f "$ROFI_CONFIG" ]]; then
    sed -i "s|@import.*colors/github-.*\.rasi.*|${rofi_import}|" "$ROFI_CONFIG"
  fi

  # Dunst
  if [[ -f "$DUNST_FILE" ]]; then
    sed -i \
      -e '/^\[global\]/,/^\[/{
        s/background = .*/background = "'"$dunst_bg"'"/
        s/foreground = .*/foreground = "'"$dunst_fg"'"/
        s/frame_color = .*/frame_color = "'"$dunst_frame"'"/
        s/highlight = .*/highlight = "'"$dunst_highlight"'"/
      }' \
      -e '/^\[urgency_low\]/,/^\[/{
        s/background = .*/background = "'"$dunst_low_bg"'"/
        s/foreground = .*/foreground = "'"$dunst_fg"'"/
        s/frame_color = .*/frame_color = "'"$dunst_low_frame"'"/
      }' \
      -e '/^\[urgency_normal\]/,/^\[/{
        s/background = .*/background = "'"$dunst_bg"'"/
        s/foreground = .*/foreground = "'"$dunst_fg"'"/
        s/frame_color = .*/frame_color = "'"$dunst_frame"'"/
      }' \
      -e '/^\[urgency_critical\]/,/^\[/{
        s/background = .*/background = "'"$dunst_bg"'"/
        s/foreground = .*/foreground = "'"$dunst_crit_fg"'"/
        s/frame_color = .*/frame_color = "'"$dunst_crit_frame"'"/
      }' \
      "$DUNST_FILE"
    killall dunst 2>/dev/null
  fi

  echo "$theme" > "$THEME_FILE"

  # Restart polybar
  polybar-msg cmd restart 2>/dev/null || (killall polybar && polybar example &)
}

toggle() {
  local current=$(get_current_theme)
  if [[ "$current" == "light" ]]; then
    set_theme "dark"
  else
    set_theme "light"
  fi
}

display() {
  local theme=$(get_current_theme)
  if [[ "$theme" == "light" ]]; then
    echo "󰖨"
  else
    echo "󰖙"
  fi
}

case "$1" in
  --toggle)
    toggle
    ;;
  --light)
    set_theme "light"
    ;;
  --dark)
    set_theme "dark"
    ;;
  --status)
    get_current_theme
    ;;
  *)
    display
    ;;
esac

exit 0
