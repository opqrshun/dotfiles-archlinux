#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
src_hotkey="$script_dir/fcitx5/hotkey.conf"
dst_dir="$HOME/.config/fcitx5/conf"
dst_hotkey="$dst_dir/hotkey.conf"

if ! command -v kwriteconfig6 >/dev/null 2>&1; then
  echo "[ERROR] kwriteconfig6 not found. Install kde-cli-tools first." >&2
  exit 1
fi

mkdir -p "$dst_dir"
install -m 0644 "$src_hotkey" "$dst_hotkey"

# Swap Caps Lock and Left Ctrl in KDE keyboard settings.
kwriteconfig6 --file kxkbrc --group Layout --key Options "ctrl:swapcaps"

# Enable dark mode using Breeze Dark for Plasma and Qt/KDE apps.
kwriteconfig6 --file kdeglobals --group General --key ColorScheme "BreezeDark"
kwriteconfig6 --file kdeglobals --group KDE --key LookAndFeelPackage "org.kde.breezedark.desktop"

if command -v plasma-apply-colorscheme >/dev/null 2>&1; then
  plasma-apply-colorscheme BreezeDark >/dev/null 2>&1 || true
fi

if ! pgrep -x fcitx5 >/dev/null 2>&1; then
  nohup fcitx5 -d >/dev/null 2>&1 &
  sleep 1
fi

if command -v fcitx5-remote >/dev/null 2>&1; then
  fcitx5-remote -r || true
else
  echo "[WARN] fcitx5-remote not found. Re-login to apply fcitx5 changes." >&2
fi

echo "[INFO] Applied KDE layer2 settings:"
echo "  - Caps Lock <-> Ctrl: ctrl:swapcaps"
echo "  - Japanese input: fcitx5 hotkey.conf deployed"
echo "  - Dark mode: BreezeDark"
echo "[INFO] Log out and log back in if keyboard/theme changes are not reflected immediately."
