#!/usr/bin/env bash
set -euo pipefail

repo_url="${LAYER2_SHELL_REPO_URL:-https://github.com/opqrshun/dotfiles-shell.git}"
repo_dir="${LAYER2_SHELL_REPO_DIR:-$HOME/.dotfiles-shell}"
repo_ref="${LAYER2_SHELL_REPO_REF:-master}"

if [[ ! -d "$repo_dir/.git" ]]; then
  git clone "$repo_url" "$repo_dir"
fi

git -C "$repo_dir" fetch --all --prune
git -C "$repo_dir" checkout "$repo_ref"
git -C "$repo_dir" pull --ff-only origin "$repo_ref" || true

bash "$repo_dir/install.sh"
