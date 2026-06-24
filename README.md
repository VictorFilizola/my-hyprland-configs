# my-hyprland-configs

Personal Hyprland environment — Lua-based config, dwindle layout, multimedia OSD, Waybar bar.

## Files

| File              | Purpose                                                                                         |
| ----------------- | ----------------------------------------------------------------------------------------------- |
| `hyprland.lua`    | Entry point — requires all modules in order                                                     |
| `colors.lua`      | Centralized color palette (accent, surface, muted, text, shadow)                                |
| `env.lua`         | Environment variables (cursor size, Qt theme)                                                   |
| `monitors.lua`    | Display configuration (auto-detect preferred)                                                   |
| `input.lua`       | Keyboard layout (`us-intl`), mouse/touchpad, per-device sensitivity, 3-finger workspace gesture |
| `appearance.lua`  | Gaps, borders, rounding, opacity, shadows, blur (off), dwindle/master presets                   |
| `animations.lua`  | Bezier curves, spring presets, window/layer/workspace animations                                |
| `programs.lua`    | User-facing app shortcuts (terminal, file manager, launcher, browser)                           |
| `keybinds.lua`    | All keybinds — window management, media keys, screenshots, workspace nav                        |
| `startup.lua`     | Daemons launched at start (Waybar, SwayOSD, SwayNC, hypridle, swaybg)                           |
| `windowrules.lua` | Window rules — suppress maximize, fix XWayland drags, float hyprland-run                        |

## Keybinds

Mod key: `SUPER` (Windows key)

| Keys                            | Action                                           |
| ------------------------------- | ------------------------------------------------ |
| `SUPER + Return`                | Terminal (kitty)                                 |
| `SUPER + Q`                     | Close window                                     |
| `SUPER + E`                     | File manager (dolphin)                           |
| `SUPER + Space`                 | App launcher (rofi)                              |
| `SUPER + M`                     | Shutdown menu                                    |
| `SUPER + Escape`                | Lock screen (hyprlock)                           |
| `SUPER + V`                     | Toggle float                                     |
| `SUPER + P`                     | Toggle pseudo-tile                               |
| `SUPER + J`                     | Toggle split direction                           |
| `SUPER + Y/U/I/O/P`             | Switch workspace 1-5                             |
| `SUPER + Shift + Y/U/I/O/P`     | Move window to workspace 1-5                     |
| `SUPER + left/right`            | Previous/next workspace                          |
| `SUPER + Shift + arrows`        | Move focus                                       |
| `SUPER + drag (LMB)`            | Move window                                      |
| `SUPER + drag (RMB)`            | Resize window                                    |
| `Print`                         | Screenshot region → annotate (hyprshot + swappy) |
| `SUPER + Shift + S`             | Screenshot region → clipboard                    |
| `XF86AudioRaiseVolume`          | Volume up + OSD                                  |
| `XF86AudioLowerVolume`          | Volume down + OSD                                |
| `XF86AudioMute`                 | Mute toggle + OSD                                |
| `XF86AudioMicMute`              | Mic mute toggle                                  |
| `XF86MonBrightnessUp`           | Brightness up + OSD                              |
| `XF86MonBrightnessDown`         | Brightness down + OSD                            |
| `XF86AudioNext/Play/Pause/Prev` | Media control (playerctl)                        |

## Dependencies

### Core

| Package    | Purpose            |
| ---------- | ------------------ |
| `hyprland` | Wayland compositor |

### Daemons (auto-started in startup.lua)

| Package    | Purpose                                                 |
| ---------- | ------------------------------------------------------- |
| `waybar`   | Status bar                                              |
| `swayosd`  | Volume/brightness OSD (swayosd-client + swayosd-server) |
| `swaync`   | Notification daemon                                     |
| `hypridle` | Idle management (auto-lock, suspend)                    |
| `swaybg`   | Wallpaper setter                                        |

### Applications

| Package                        | Purpose                                        |
| ------------------------------ | ---------------------------------------------- |
| `kitty`                        | Terminal emulator                              |
| `dolphin`                      | File manager                                   |
| `rofi` or `rofi-lbonn-wayland` | App launcher (Wayland-native fork recommended) |
| `brave`                        | Web browser                                    |

### Utilities

| Package       | Purpose                                             |
| ------------- | --------------------------------------------------- |
| `hyprshot`    | Screenshot tool (AUR: `hyprshot` or `hyprshot-git`) |
| `swappy`      | Screenshot annotation                               |
| `hyprlock`    | Screen locker                                       |
| `wireplumber` | Audio routing (provides `wpctl`)                    |
| `playerctl`   | Media player control                                |
| `psmisc`      | Provides `killall` (for swaybg restart)             |
| `procps-ng`   | Provides `pkill` (for daemon restarts)              |

### Install (Arch)

```bash
sudo pacman -S hyprland waybar swaync hypridle swaybg kitty dolphin rofi-lbonn-wayland swappy hyprlock wireplumber playerctl
paru -S hyprshot-git swayosd
```

## SwayOSD — systemd backend (required)

Volume/brightness OSD uses SwayOSD. It has two parts:

- `swayosd-libinput-backend` — **system** service (root), reads input devices
- `swayosd-server` — **user** process, shows OSD + changes volume

The systemd backend must be **enabled** or OSD + volume keys silently fail:

```bash
sudo systemctl enable --now swayosd-libinput-backend.service
```

Verify:

```bash
systemctl is-active swayosd-libinput-backend.service  # → active
```

No OSD without this. Volume keys do nothing without this.

## Customization

- Terminal: edit `programs.lua` → `terminal`
- File manager: edit `programs.lua` → `fileManager`
- Launcher: edit `programs.lua` → `menu`
- Browser: edit `programs.lua` → `browser`
- Wallpaper path: edit `startup.lua` → `swaybg` command
- Gaps, borders, opacity: edit `appearance.lua`
- Keybinds: edit `keybinds.lua`
