#!/usr/bin/env bash
set -euo pipefail

log() { printf "\n[%s] %s\n" "$(date '+%F %T')" "$*"; }

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

  log "Layer2 install complete."
}

main "$@"
