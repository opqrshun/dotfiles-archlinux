#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
src_hotkey="$script_dir/fcitx5/hotkey.conf"
dst_dir="$HOME/.config/fcitx5/conf"
dst_hotkey="$dst_dir/hotkey.conf"

command -v gsettings >/dev/null 2>&1 || {
  echo "[ERROR] gsettings not found." >&2
  exit 1
}

mkdir -p "$dst_dir"
install -m 0644 "$src_hotkey" "$dst_hotkey"

gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

if command -v fcitx5-remote >/dev/null 2>&1; then
  fcitx5-remote -r || true
else
  echo "[WARN] fcitx5-remote not found. Re-login to apply fcitx5 changes." >&2
fi
