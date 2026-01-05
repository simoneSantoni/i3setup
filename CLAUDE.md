# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Dotfiles repository for a Linux desktop environment with an integrated Ubuntu Yaru-inspired color scheme across all components:
- **i3** - Tiling window manager
- **polybar** - Status bar with custom modules
- **rofi** - Application launcher
- **dunst** - Notification daemon

## Ubuntu Yaru Color Scheme

All components share a consistent color palette:

| Role | Dark Theme | Light Theme | Usage |
|------|-----------|-------------|-------|
| Primary | `#E95420` | `#E95420` | Ubuntu orange - focused windows, active elements, accents |
| Secondary | `#914691` | `#914691` | Aubergine purple - secondary highlights |
| Background | `#2c2c2c` | `#d2d2d2` | Polybar, UI backgrounds |
| Background Alt | `#3c3c3c` | `#c2c2c2` | Active workspace, hover states |
| Foreground | `#d2d2d2` | `#3d3d3d` | Text |
| Alert | `#C42729` | `#C42729` | Urgent notifications |
| Disabled | `#6d6d6d` | `#8d8d8d` | Inactive elements |

Rofi and dunst use a darker variant (`#300a24` aubergine background) matching the Kitty terminal theme.

## Key Bindings (i3)

- `Mod+Return` - Terminal (kitty)
- `Mod+x` - Rofi launcher
- `Mod+d` - dmenu
- `Mod+p` - Toggle polybar visibility
- `Mod+F1-F3` - Volume mute/down/up
- `Mod+F4` - Mic mute
- `Mod+F5-F6` - Brightness down/up
- `Print` - Screenshot (flameshot)

## Polybar Modules

Custom scripts in `polybar/scripts/`:
- `brightness.sh` - Screen brightness control (scroll to adjust)
- `caffeine.sh` - Prevent screen sleep toggle
- `keyboard-layout.sh` - GB/US layout switching
- `microphone.sh` - PipeWire mic mute toggle
- `screen-layout.sh` - Multi-monitor layout cycling
- `theme-toggle.sh` - Light/dark polybar theme switching

## Testing Changes

```bash
# i3
i3-msg reload                    # Reload config
Mod+Shift+r                      # Restart in-place

# Polybar
~/.config/polybar/launch.sh      # Restart on all monitors

# Rofi
rofi -show drun -theme ~/.config/rofi/launchers/type-3/style-10.rasi

# Dunst
killall dunst && dunst &
notify-send "Test"               # Send test notification
```

## Dependencies

- Fonts: UbuntuSans Nerd Font, UbuntuMono Nerd Font Mono, Symbols Nerd Font
- Icons: Papirus icon theme
- Tools: brightnessctl, wpctl (PipeWire), xkb-switch (optional), feh, flameshot
