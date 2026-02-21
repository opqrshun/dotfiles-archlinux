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

layer2

```bash
./layer2/install.sh
```

日本語入力切替 (GNOME + fcitx5)

```bash
./layer2/gnome.sh
```

`layer2/gnome.sh` is the entrypoint and calls `layer2/apply-input.sh`.
It deploys `~/.config/fcitx5/conf/hotkey.conf` and does not force current IM.

検証:
- `gsettings get org.gnome.desktop.wm.keybindings switch-input-source` が `[]`
- `gsettings get org.gnome.desktop.input-sources xkb-options` に `ctrl:nocaps` が含まれる
- `gsettings get org.gnome.desktop.interface color-scheme` が `'prefer-dark'`
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
