#!/usr/bin/env bash
set -euo pipefail

# Remove only core GNOME components. No KDE-related operations here.
pkgs=(
  gdm
  gnome-shell
  gnome-control-center
  gnome-session
  gnome-settings-daemon
  gnome-keyring
  gnome-tweaks
  gnome-shell-extensions
)

installed=()
for pkg in "${pkgs[@]}"; do
  if pacman -Q "$pkg" >/dev/null 2>&1; then
    installed+=("$pkg")
  fi
done

if (( ${#installed[@]} == 0 )); then
  echo "[INFO] No target GNOME packages are installed."
  exit 0
fi

echo "[INFO] Removing GNOME packages: ${installed[*]}"
sudo systemctl disable --now gdm.service >/dev/null 2>&1 || true
sudo pacman -Rns --noconfirm "${installed[@]}"

echo "[INFO] Done. Reboot is recommended."
