# dotfiles-archlinux-2


layer1

```
bash <(curl -fsSL https://raw.githubusercontent.com/opqrshun/dotfiles-archlinux-2/dev/bootstrap.sh)
```

```
BOOTSTRAP_INSTALL_YAY=1 \
BOOTSTRAP_INSTALL_CHROME=1 \
BOOTSTRAP_INSTALL_VSCODE=1 \
bash <(curl -fsSL https://raw.githubusercontent.com/opqrshun/dotfiles-archlinux-2/dev/bootstrap.sh)
```

Install all configured AUR packages at once:

```
BOOTSTRAP_INSTALL_AUR_ALL=1 \
bash <(curl -fsSL https://raw.githubusercontent.com/opqrshun/dotfiles-archlinux-2/dev/bootstrap.sh)
```

`lazygit` is included in default dev packages.

Desktop install is opt-in (not included in `BOOTSTRAP_INSTALL_AUR_ALL`):

```bash
BOOTSTRAP_INSTALL_GNOME=1 \
BOOTSTRAP_ENABLE_GDM=1 \
bash <(curl -fsSL https://raw.githubusercontent.com/opqrshun/dotfiles-archlinux-2/dev/bootstrap.sh)
```

layer2

```bash
./layer2/install.sh
```

GNOME 設定 (Caps/Ctrl 入れ替え + 日本語入力 + ダークモード)

```bash
./layer2/gnome.sh
```

`layer2/gnome.sh` is the entrypoint and calls `layer2/apply-input.sh`.
It deploys `~/.config/fcitx5/conf/hotkey.conf`, sets Caps Lock/Ctrl swap, and applies dark mode.

KDE 関連パッケージを削除:

```bash
./layer2/remove-kde.sh
```

検証:
- `gsettings get org.gnome.desktop.wm.keybindings switch-input-source` が `[]`
- `gsettings get org.gnome.desktop.input-sources xkb-options` に `ctrl:nocaps` が含まれる
- `gsettings get org.gnome.desktop.interface color-scheme` が `'prefer-dark'`
- `~/.config/fcitx5/conf/hotkey.conf` が配置されている
- `Ctrl+Space` で日本語/英語が切り替わる
- 反映されない場合は `fcitx5-remote -r` または再ログイン
- それでもダメな場合は `pgrep -ax fcitx5` で fcitx5 プロセスの起動有無を確認

Check `.zshrc` link target:

```bash
readlink ~/.zshrc
```

Manual install (alternative):

```bash
rm -f ~/.dotfiles-shell
git clone https://github.com/opqrshun/dotfiles-shell.git ~/.dotfiles-shell
bash ~/.dotfiles-shell/install.sh
```
