# i3setup

A collection of themed i3 desktop environments with color-consistent configurations across all components.

## Themes

### yaru-theme — Ubuntu Yaru

```
Primary     #E95420  ████  Ubuntu Orange (focused windows, accents)
Secondary   #914691  ████  Aubergine Purple
Background  #2c2c2c  ████  Dark grey (polybar)
Accent BG   #300a24  ████  Deep aubergine (rofi, dunst — matches Kitty)
Alert       #C42729  ████  Red (urgent)
```

Polybar supports **light/dark theme toggle** — click the sun/moon icon.

### duotone — Base2Tone Field Dark

```
Primary     #00943e  ████  Green (focused windows, accents)
Secondary   #0fbda0  ████  Teal
Background  #18201e  ████  Dark green-grey (polybar)
Accent      #3be381  ████  Bright green
Alert       #55ec94  ████  Light green (urgent)
```

Includes a **speaker output selector** module and an extensive rofi collection with 18 color schemes, 7 launcher types, applets, and power menus.

## Components

| Component | Description |
|-----------|-------------|
| **i3** | Tiling window manager with 5px gaps and 3px borders |
| **polybar** | Bottom status bar with custom script-driven modules |
| **rofi** | Application launcher |
| **dunst** | Notification daemon |

## Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/i3setup.git
cd i3setup

# Pick a theme
THEME=yaru-theme   # or: duotone

# Backup existing configs (optional)
for d in i3 polybar rofi dunst; do
  [ -d ~/.config/$d ] && mv ~/.config/$d ~/.config/$d.bak
done

# Copy configs
cp -r $THEME/i3 $THEME/polybar $THEME/rofi $THEME/dunst ~/.config/

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
- `xkb-switch` — keyboard layout switching (falls back to setxkbmap)
- `papirus-icon-theme` — icon theme for rofi
- `flameshot` — screenshot tool
- `wpctl` (PipeWire) — microphone control

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
| `Print` | Screenshot (flameshot) |

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
| Speaker | Audio output selector (duotone only) | Click to cycle |
| Memory/CPU | System stats | — |
| Battery | Charge status | — |
| WiFi | Network status | — |
| Date/Time | Clock | — |

## Customization

**Change accent color** — update in all four files within a theme:
- `i3/config` — `client.focused` border color
- `polybar/config.ini` — `primary` in `[colors]`
- `rofi/colors/*.rasi` — `selected` value
- `dunst/dunstrc` — `frame_color` values
- `polybar/scripts/*.sh` — hardcoded hex values for active/disabled states

**Change wallpaper** — edit `i3/config`:
```bash
exec --no-startup-id feh --bg-fill ~/Pictures/your-wallpaper.jpg
```

**Add keyboard layouts** — edit `polybar/scripts/keyboard-layout.sh`:
```bash
local layouts=("gb" "us" "de")  # Add more layouts
```

## License

MIT
