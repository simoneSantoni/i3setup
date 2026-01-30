#!/bin/bash

# theme-toggle.sh - Toggle between light and dark polybar themes

CONFIG_FILE="$HOME/.config/polybar/config.ini"
THEME_FILE="/tmp/polybar_theme"

# Light theme (Base2Tone Field Light)
LIGHT_BG="#f9fbfa"
LIGHT_BG_ALT="#e8edec"
LIGHT_FG="#42524f"
LIGHT_PRIMARY="#00943e"
LIGHT_SECONDARY="#0fbda0"
LIGHT_ALERT="#55ec94"
LIGHT_DISABLED="#667a77"

# Dark theme (Base2Tone Field Dark)
DARK_BG="#18201e"
DARK_BG_ALT="#242e2c"
DARK_FG="#8ea4a0"
DARK_PRIMARY="#00943e"
DARK_SECONDARY="#0fbda0"
DARK_ALERT="#55ec94"
DARK_DISABLED="#5a6d6a"

get_current_theme() {
  if [[ -f "$THEME_FILE" ]]; then
    cat "$THEME_FILE"
  else
    # Check config to determine current theme
    if grep -q "^background = #d2d2d2" "$CONFIG_FILE" 2>/dev/null; then
      echo "light"
    else
      echo "dark"
    fi
  fi
}

set_theme() {
  local theme="$1"

  if [[ "$theme" == "dark" ]]; then
    sed -i "s/^background = .*/background = $DARK_BG/" "$CONFIG_FILE"
    sed -i "s/^background-alt = .*/background-alt = $DARK_BG_ALT/" "$CONFIG_FILE"
    sed -i "s/^foreground = .*/foreground = $DARK_FG/" "$CONFIG_FILE"
    sed -i "s/^primary = .*/primary = $DARK_PRIMARY/" "$CONFIG_FILE"
    sed -i "s/^secondary = .*/secondary = $DARK_SECONDARY/" "$CONFIG_FILE"
    sed -i "s/^alert = .*/alert = $DARK_ALERT/" "$CONFIG_FILE"
    sed -i "s/^disabled = .*/disabled = $DARK_DISABLED/" "$CONFIG_FILE"
    echo "dark" > "$THEME_FILE"
  else
    sed -i "s/^background = .*/background = $LIGHT_BG/" "$CONFIG_FILE"
    sed -i "s/^background-alt = .*/background-alt = $LIGHT_BG_ALT/" "$CONFIG_FILE"
    sed -i "s/^foreground = .*/foreground = $LIGHT_FG/" "$CONFIG_FILE"
    sed -i "s/^primary = .*/primary = $LIGHT_PRIMARY/" "$CONFIG_FILE"
    sed -i "s/^secondary = .*/secondary = $LIGHT_SECONDARY/" "$CONFIG_FILE"
    sed -i "s/^alert = .*/alert = $LIGHT_ALERT/" "$CONFIG_FILE"
    sed -i "s/^disabled = .*/disabled = $LIGHT_DISABLED/" "$CONFIG_FILE"
    echo "light" > "$THEME_FILE"
  fi

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
    echo "󰖨"  # Sun icon for light mode
  else
    echo "󰖙"  # Moon icon for dark mode
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
