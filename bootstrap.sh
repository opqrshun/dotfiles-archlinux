#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------
# Arch Linux Layer1 bootstrap (GNOME/Wayland friendly)
# - Updates system
# - Installs base/dev tools
# - Installs IME (fcitx5 + mozc) and basic fonts
# - Optionally installs yay (AUR helper)
#
# Usage:
#   chmod +x bootstrap.sh
#   ./bootstrap.sh
#
# Optional env flags:
#   BOOTSTRAP_INSTALL_YAY=1          # build yay from AUR
#   BOOTSTRAP_INSTALL_CHROME=1       # install google-chrome (AUR) via yay
#   BOOTSTRAP_INSTALL_VSCODE=1       # install visual-studio-code-bin (AUR) via yay
#   BOOTSTRAP_SKIP_IME=1             # skip fcitx5/mozc setup
#   BOOTSTRAP_SKIP_FONTS=1           # skip fonts
#   BOOTSTRAP_SKIP_DEVTOOLS=1        # skip dev tools
# ------------------------------------------------------------

log() { printf "\n[%s] %s\n" "$(date '+%F %T')" "$*"; }
die() { printf "\nERROR: %s\n" "$*" >&2; exit 1; }

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "command not found: $1"
}

is_arch() {
  [[ -f /etc/arch-release ]]
}

pac_install() {
  # Installs packages only if missing
  # Usage: pac_install pkg1 pkg2 ...
  local pkgs=("$@")
  sudo pacman -S --needed --noconfirm "${pkgs[@]}"
}

ensure_sudo() {
  if ! sudo -n true 2>/dev/null; then
    log "sudo password may be required."
  fi
  sudo true
}

install_yay() {
  if command -v yay >/dev/null 2>&1; then
    log "yay already installed."
    return 0
  fi

  require_cmd git
  require_cmd makepkg

  log "Installing yay (AUR helper) ..."
  local tmpdir
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' EXIT

  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
  (cd "$tmpdir/yay" && makepkg -si --noconfirm)

  log "yay installed."
}

configure_fcitx5_env() {
  # GNOME + Wayland: environment.d is the cleanest.
  # This is per-user (not system-wide).
  local envdir="$HOME/.config/environment.d"
  local envfile="$envdir/90-fcitx5.conf"

  mkdir -p "$envdir"
  cat > "$envfile" <<'EOF'
# Fcitx5 IME environment
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
EOF

  log "Wrote: $envfile"
}

main() {
  is_arch || die "This script is for Arch Linux."

  require_cmd pacman
  ensure_sudo

  log "Starting Layer1 bootstrap."

  # 0) Time sync (helps TLS/keys if clock is off)
  if command -v timedatectl >/dev/null 2>&1; then
    log "Enabling NTP time sync (if available)."
    sudo timedatectl set-ntp true || true
  fi

  # 1) Update system
  log "System update: pacman -Syu"
  sudo pacman -Syu --noconfirm

  # 2) Base tools
  log "Installing base tools"
  pac_install git base-devel curl wget unzip zip rsync jq openssh ca-certificates

  # 3) Dev / CLI tools
  if [[ "${BOOTSTRAP_SKIP_DEVTOOLS:-0}" != "1" ]]; then
    log "Installing dev/cli tools"
    pac_install neovim tmux htop btop ripgrep fd bat tree less which man-db man-pages
    pac_install python python-pip
  else
    log "Skipping dev tools (BOOTSTRAP_SKIP_DEVTOOLS=1)"
  fi

  # 4) Fonts
  if [[ "${BOOTSTRAP_SKIP_FONTS:-0}" != "1" ]]; then
    log "Installing fonts (CJK + emoji)"
    pac_install noto-fonts noto-fonts-cjk noto-fonts-emoji
  else
    log "Skipping fonts (BOOTSTRAP_SKIP_FONTS=1)"
  fi

  # 5) IME (Fcitx5 + Mozc)
  if [[ "${BOOTSTRAP_SKIP_IME:-0}" != "1" ]]; then
    log "Installing IME (fcitx5 + mozc)"
    pac_install fcitx5 fcitx5-im fcitx5-mozc fcitx5-configtool
    configure_fcitx5_env
    log "IME setup done. You will need to log out & log in (or reboot) for env changes."
  else
    log "Skipping IME (BOOTSTRAP_SKIP_IME=1)"
  fi

  # 6) Optional: yay + AUR apps
  if [[ "${BOOTSTRAP_INSTALL_YAY:-0}" == "1" || "${BOOTSTRAP_INSTALL_CHROME:-0}" == "1" || "${BOOTSTRAP_INSTALL_VSCODE:-0}" == "1" ]]; then
    log "AUR path requested: installing yay"
    install_yay
  fi

  if [[ "${BOOTSTRAP_INSTALL_CHROME:-0}" == "1" ]]; then
    log "Installing google-chrome (AUR) via yay"
    yay -S --needed --noconfirm google-chrome
  fi

  if [[ "${BOOTSTRAP_INSTALL_VSCODE:-0}" == "1" ]]; then
    log "Installing VS Code (AUR) via yay"
    yay -S --needed --noconfirm visual-studio-code-bin
  fi

  log "Layer1 bootstrap finished."
  log "Next actions:"
  echo "  - Re-login or reboot to apply IME env:  logout/login (or reboot)"
  echo "  - Then proceed to Layer2 (dotfiles)."
}

main "$@"
