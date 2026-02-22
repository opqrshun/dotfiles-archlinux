#!/usr/bin/env bash
set -euo pipefail

# Remove core KDE/Plasma components to switch back to GNOME.
pkgs=(
  plasma-meta
  plasma-desktop
  plasma-workspace
  plasma-workspace-wallpapers
  kde-cli-tools
  kde-gtk-config
  kdeplasma-addons
  sddm
  konsole
  dolphin
)

installed=()
for pkg in "${pkgs[@]}"; do
  if pacman -Q "$pkg" >/dev/null 2>&1; then
    installed+=("$pkg")
  fi
done

if (( ${#installed[@]} == 0 )); then
  echo "[INFO] No target KDE packages are installed."
  exit 0
fi

echo "[INFO] Removing KDE packages: ${installed[*]}"
sudo systemctl disable --now sddm.service >/dev/null 2>&1 || true
sudo pacman -Rns --noconfirm "${installed[@]}"

echo "[INFO] Done. Reboot is recommended."
echo "[INFO] If needed, enable GNOME display manager: sudo systemctl enable gdm.service"
