# i3setup

A cohesive i3 desktop environment with an integrated **Ubuntu Yaru-inspired color scheme** across all components.

## Overview

| Component | Description |
|-----------|-------------|
| **i3** | Tiling window manager with 5px gaps and 3px borders |
| **polybar** | Bottom status bar with custom modules |
| **rofi** | Grid-style application launcher |
| **dunst** | Notification daemon |

## Color Scheme

Consistent Ubuntu Yaru palette across all components:

```
Primary     #E95420  ████  Ubuntu Orange (focused windows, accents)
Secondary   #914691  ████  Aubergine Purple
Background  #2c2c2c  ████  Dark grey (polybar)
Accent BG   #300a24  ████  Deep aubergine (rofi, dunst)
Alert       #C42729  ████  Red (urgent)
```

Polybar supports **light/dark theme toggle** - click the sun/moon icon.

## Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/i3setup.git
cd i3setup

# Backup existing configs (optional)
for d in i3 polybar rofi dunst; do
  [ -d ~/.config/$d ] && mv ~/.config/$d ~/.config/$d.bak
done

# Copy configs
cp -r i3 polybar rofi dunst ~/.config/

# Make scripts executable
chmod +x ~/.config/polybar/launch.sh ~/.config/polybar/scripts/*.sh

# Reload i3
i3-msg reload
```

## Dependencies

**Fonts** (install via your package manager or [Nerd Fonts](https://www.nerdfonts.com/)):
- UbuntuSans Nerd Font
- UbuntuMono Nerd Font Mono
- Symbols Nerd Font

**Packages:**
```bash
# Arch
sudo pacman -S i3-wm polybar rofi dunst feh brightnessctl

# Ubuntu/Debian
sudo apt install i3 polybar rofi dunst feh brightnessctl
```

**Optional:**
- `xkb-switch` - for keyboard layout switching
- `papirus-icon-theme` - icon theme for rofi

## Key Bindings

| Binding | Action |
|---------|--------|
| `Mod+Return` | Terminal (kitty) |
| `Mod+x` | Rofi launcher |
| `Mod+d` | dmenu |
| `Mod+p` | Toggle polybar |
| `Mod+Shift+q` | Kill window |
| `Mod+f` | Fullscreen |
| `Mod+r` | Resize mode |
| `Mod+1-0` | Switch workspace |
| `Mod+Shift+1-0` | Move to workspace |
| `Mod+F1` | Mute audio |
| `Mod+F2/F3` | Volume down/up |
| `Mod+F4` | Mute microphone |
| `Mod+F5/F6` | Brightness down/up |

## Polybar Modules

| Module | Function | Interaction |
|--------|----------|-------------|
| Workspaces | i3 workspace indicator | Click to switch |
| Keyboard | GB/US layout | Click to cycle |
| Caffeine | Prevent screen sleep | Click to toggle |
| Theme | Light/dark mode | Click to toggle |
| Brightness | Screen brightness | Scroll to adjust |
| Layout | Multi-monitor arrangement | Click to switch |
| Volume | PulseAudio control | Click to mute |
| Microphone | PipeWire mic mute | Click to toggle |
| Memory/CPU | System stats | - |
| Battery | Charge status | - |
| WiFi | Network status | - |
| Date/Time | Clock | - |

## File Structure

```
~/.config/
├── i3/config                 # Window manager
├── dunst/dunstrc             # Notifications
├── polybar/
│   ├── config.ini            # Bar configuration
│   ├── launch.sh             # Multi-monitor launcher
│   └── scripts/
│       ├── brightness.sh
│       ├── caffeine.sh
│       ├── keyboard-layout.sh
│       ├── microphone.sh
│       ├── monitor-toggle.sh
│       ├── screen-layout.sh
│       └── theme-toggle.sh
└── rofi/
    ├── config.rasi           # Main config
    ├── colors/yaru.rasi      # Color definitions
    └── launchers/type-3/     # Grid launcher theme
```

## Customization

**Change accent color:** Update `#E95420` in:
- `i3/config` - `client.focused` line
- `polybar/config.ini` - `primary` in `[colors]`
- `rofi/colors/yaru.rasi` - `selected` value
- `dunst/dunstrc` - `frame_color` values

**Change wallpaper:** Edit `i3/config`:
```bash
exec --no-startup-id feh --bg-fill ~/Pictures/your-wallpaper.jpg
```

**Add keyboard layouts:** Edit `polybar/scripts/keyboard-layout.sh`:
```bash
local layouts=("gb" "us" "de")  # Add more layouts
```

## License

MIT
