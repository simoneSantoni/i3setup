#!/bin/bash

# theme-toggle.sh - Toggle between light and dark polybar themes

CONFIG_FILE="$HOME/.config/polybar/config.ini"
THEME_FILE="/tmp/polybar_theme"

# Light theme (GitHub Light)
LIGHT_BG="#ffffff"
LIGHT_BG_ALT="#f6f8fa"
LIGHT_FG="#1f2328"
LIGHT_PRIMARY="#0969da"
LIGHT_SECONDARY="#0550ae"
LIGHT_ALERT="#cf222e"
LIGHT_DISABLED="#8c959f"

# Dark theme (GitHub Dark)
DARK_BG="#0d1117"
DARK_BG_ALT="#161b22"
DARK_FG="#e6edf3"
DARK_PRIMARY="#2f81f7"
DARK_SECONDARY="#1f6feb"
DARK_ALERT="#f85149"
DARK_DISABLED="#484f58"

get_current_theme() {
  if [[ -f "$THEME_FILE" ]]; then
    cat "$THEME_FILE"
  else
    # Check config to determine current theme
    if grep -q "^background = #ffffff" "$CONFIG_FILE" 2>/dev/null; then
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
