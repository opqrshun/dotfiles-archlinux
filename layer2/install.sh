#!/usr/bin/env bash
set -euo pipefail

log() { printf "\n[%s] %s\n" "$(date '+%F %T')" "$*"; }

set_default_shell_to_zsh() {
  if [[ "${LAYER2_SKIP_CHSH:-0}" == "1" ]]; then
    log "Skipping default shell change (LAYER2_SKIP_CHSH=1)."
    return 0
  fi

  if ! command -v zsh >/dev/null 2>&1; then
    log "zsh is not installed. Install zsh first."
    return 0
  fi

  if ! command -v chsh >/dev/null 2>&1; then
    log "chsh command not found. Set your shell manually."
    return 0
  fi

  local zsh_path current_shell
  zsh_path="$(command -v zsh)"
  current_shell="$(getent passwd "$USER" | cut -d: -f7 || true)"

  if [[ "$current_shell" == "$zsh_path" ]]; then
    log "Default shell is already zsh: $zsh_path"
    return 0
  fi

  if [[ -r /etc/shells ]] && ! grep -qx "$zsh_path" /etc/shells; then
    log "zsh path is not listed in /etc/shells: $zsh_path"
    log "Run manually after adding it to /etc/shells."
    return 0
  fi

  if chsh -s "$zsh_path" "$USER"; then
    log "Default shell updated to zsh: $zsh_path"
    log "Open a new terminal session to apply the change."
  else
    log "Failed to change shell automatically."
    log "Try manually: chsh -s $zsh_path"
  fi
}

main() {
  local repo_root
  repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  local home_dir="$repo_root/layer2/home"
  local backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
  local files=(.zshenv .zprofile .zshrc .tmux.conf)

  mkdir -p "$backup_dir"

  for name in "${files[@]}"; do
    local src="$home_dir/$name"
    local dst="$HOME/$name"

    if [[ ! -e "$src" ]]; then
      log "skip missing source: $src"
      continue
    fi

    if [[ -L "$dst" ]]; then
      rm -f "$dst"
    elif [[ -e "$dst" ]]; then
      log "backup: $dst -> $backup_dir/$name"
      mv "$dst" "$backup_dir/$name"
    fi

    ln -s "$src" "$dst"
    log "linked: $dst -> $src"
  done

  set_default_shell_to_zsh

  log "Layer2 install complete."
}

main "$@"
