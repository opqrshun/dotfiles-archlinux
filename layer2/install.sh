#!/usr/bin/env bash
set -euo pipefail

repo_url="${LAYER2_SHELL_REPO_URL:-https://github.com/opqrshun/dotfiles-shell.git}"
repo_dir="${LAYER2_SHELL_REPO_DIR:-$HOME/.dotfiles-shell}"
repo_ref="${LAYER2_SHELL_REPO_REF:-master}"
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$repo_dir" == ~/* ]]; then
  repo_dir="${HOME}/${repo_dir#~/}"
fi
[[ "$repo_dir" == /* ]] || { echo "[ERROR] LAYER2_SHELL_REPO_DIR must be absolute: $repo_dir" >&2; exit 1; }

repo_dir="${repo_dir%/}"

if [[ -L "$repo_dir" ]]; then
  link_target="$(readlink "$repo_dir" || true)"
  if [[ "$link_target" == "$repo_dir" || "$link_target" == "~/.dotfiles-shell" || "$link_target" == "$HOME/.dotfiles-shell" ]]; then
    echo "[WARN] Self-referencing symlink detected: $repo_dir -> $link_target" >&2
    echo "[WARN] Removing broken symlink: $repo_dir" >&2
    rm -f "$repo_dir"
  fi
fi

if [[ ! -d "$repo_dir/.git" ]]; then
  git clone "$repo_url" "$repo_dir"
fi

git -C "$repo_dir" fetch --all --prune
git -C "$repo_dir" checkout "$repo_ref"
git -C "$repo_dir" pull --ff-only origin "$repo_ref" || true

bash "$repo_dir/install.sh"
