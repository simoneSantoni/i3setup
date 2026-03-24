# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Dotfiles repository for a Linux i3 desktop environment with multiple self-contained themes. Each theme provides a complete, color-consistent configuration across: **i3** (window manager), **polybar** (status bar), **rofi** (application launcher), **dunst** (notification daemon), and **kitty** (terminal emulator).

## Repository Structure

```text
<theme-name>/
├── i3/config
├── kitty/                      # (duotone, github — yaru-theme has no kitty config)
│   ├── kitty.conf
│   └── current-theme.conf     # Color theme (included by kitty.conf)
├── polybar/
│   ├── config.ini
│   ├── launch.sh
│   └── scripts/               # Custom polybar modules (bash)
├── rofi/
│   ├── config.rasi
│   ├── colors/                # Color scheme definitions
│   ├── launchers/             # Launcher style themes
│   ├── applets/               # (duotone only) System control applets with shell scripts
│   ├── powermenu/             # (duotone only) Shutdown/restart/lock menus
│   └── images/                # (duotone only) Background images for launcher themes
└── dunst/dunstrc
```

Each theme directory is fully self-contained. To deploy a theme, copy its subdirectories into `~/.config/`.

**Theme scope differences:** yaru-theme is minimal (1 rofi launcher type, no kitty config). duotone is extensive (18 color schemes, 7 launcher types, 5 applet types, 6 powermenu types, kitty integration). github-dark has kitty integration and the same module set as duotone (including speaker-select).

## Themes

### yaru-theme — Ubuntu Yaru

| Role | Dark | Light | Hex |
|------|------|-------|-----|
| Primary | Ubuntu Orange | same | `#E95420` |
| Secondary | Aubergine | same | `#914691` |
| Background | Dark grey | Light grey | `#2c2c2c` / `#d2d2d2` |
| Foreground | Light text | Dark text | `#d2d2d2` / `#3d3d3d` |
| Alert | Red | same | `#C42729` |

Rofi and dunst use `#300a24` (deep aubergine) as background, matching the Kitty terminal theme.

### duotone — Base2Tone Field Dark

| Role | Hex |
|------|-----|
| Primary | `#00943e` (green) |
| Secondary | `#0fbda0` (teal) |
| Background | `#18201e` |
| Foreground | `#8ea4a0` |
| Accent | `#3be381` |
| Alert | `#55ec94` |

Includes kitty terminal config, an extensive rofi collection (18 color schemes, 7 launcher types, 5 applet types, 6 powermenu types).

### github-dark — GitHub Dark

| Role | Dark | Light | Hex |
|------|------|-------|-----|
| Primary | Blue | Blue | `#2f81f7` / `#0969da` |
| Secondary | Blue emphasis | Blue emphasis | `#1f6feb` / `#0550ae` |
| Background | Dark | White | `#0d1117` / `#ffffff` |
| Foreground | Light | Dark | `#e6edf3` / `#1f2328` |
| Alert | Red | Red | `#f85149` / `#cf222e` |
| Accent | Light blue | — | `#58a6ff` |
| Disabled | Grey | Grey | `#484f58` / `#8c959f` |

Based on [projekt0n/github-nvim-theme](https://github.com/projekt0n/github-nvim-theme). Includes kitty terminal config with full GitHub Dark ANSI 16-color palette, speaker-select module, and light/dark theme toggle.

## Architecture: Cross-Component Integration

Color consistency is the core architectural concern. When changing a theme's accent color, update these files:

- `i3/config` — `client.focused` border color
- `kitty/current-theme.conf` — `cursor`, terminal colors (duotone, github-dark)
- `polybar/config.ini` — `primary` in `[colors]`
- `polybar/scripts/*.sh` — hardcoded hex values for active/disabled states
- `rofi/colors/*.rasi` — `selected` value
- `dunst/dunstrc` — `frame_color` values

**Wallpaper** is set in `i3/config` via `exec --no-startup-id feh --bg-fill <path>`.

**i3 → polybar:** i3 config launches polybar via `exec_always ~/.config/polybar/launch.sh` and toggles it with `polybar-msg cmd toggle`.

**i3 → rofi:** i3 binds `Mod+x` to launch rofi with a specific theme path (`~/.config/rofi/launchers/type-3/style-10.rasi`).

**rofi color chain:** `config.rasi` → imports `colors/<scheme>.rasi`; launcher styles → import `shared/colors.rasi` → imports the same scheme file.

**Polybar scripts** use hardcoded `%{F#hex}` color markup (e.g., `#E95420` for active, `#6d6d6d` for disabled). Note: `speaker-select.sh` exists in duotone and github-dark only. The github-dark theme centralizes script colors in `polybar/scripts/colors.sh` — scripts source it instead of hardcoding hex values, so icon colors follow the active light/dark theme automatically.

**Theme toggle scope differs by theme:** yaru-theme and duotone `theme-toggle.sh` only update `polybar/config.ini` with sed. The github-dark `theme-toggle.sh` updates polybar, rofi (both `config.rasi` and `shared/colors.rasi` imports), and dunst (`dunstrc` urgency sections) in a single pass, then restarts both polybar and dunst. It accepts `--light`, `--dark`, `--toggle`, and `--status` flags.

**rofi applets/powermenu (duotone only):** Each applet type and powermenu type has its own shell script (`*.sh`) plus `.rasi` style files. Applets share a common `applets/shared/theme.bash` utility for color/font configuration.

**State files** used by polybar scripts: `/tmp/caffeine_enabled`, `/tmp/screen_layout`, `/tmp/polybar_theme`.

## Polybar Scripts Convention

All scripts in `polybar/scripts/` follow the same pattern:
- Bash strict mode: `set -o errexit -o nounset -o pipefail`
- Output polybar-formatted text with `%{F#hex}` color markup
- Support tool fallbacks (e.g., brightnessctl/xbacklight, xkb-switch/setxkbmap)
- `theme-toggle.sh` modifies `config.ini` in place with sed, then restarts polybar

## Key Bindings (i3, shared across themes)

- `Mod+Return` — kitty terminal
- `Mod+x` — rofi launcher
- `Mod+d` — dmenu
- `Mod+p` — toggle polybar visibility
- `Mod+F1-F3` — volume mute/down/up
- `Mod+F4` — mic mute
- `Mod+F5-F6` — brightness down/up
- `Print` — flameshot screenshot

## Testing Changes

```bash
# i3
i3-msg reload                    # Reload config
# Mod+Shift+r                   # Restart in-place

# Polybar
~/.config/polybar/launch.sh      # Restart on all monitors

# Rofi
rofi -show drun -theme ~/.config/rofi/launchers/type-3/style-10.rasi

# Dunst
killall dunst && dunst &
notify-send "Test"
```

## Dependencies

- **Fonts:** UbuntuSans Nerd Font, UbuntuMono Nerd Font Mono, Symbols Nerd Font
- **Icons:** Papirus icon theme
- **Required:** i3-wm, polybar, rofi, dunst, kitty, feh, brightnessctl
- **Optional:** xkb-switch, wpctl (PipeWire), flameshot, xrandr, dex, nm-applet, xss-lock
