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
BOOTSTRAP_INSTALL_KDE=1 \
BOOTSTRAP_ENABLE_SDDM=1 \
bash <(curl -fsSL https://raw.githubusercontent.com/opqrshun/dotfiles-archlinux-2/dev/bootstrap.sh)
```

layer2

```bash
./layer2/install.sh
```

KDE 設定 (Caps/Ctrl 入れ替え + 日本語入力 + ダークモード)

```bash
./layer2/kde.sh
```

`layer2/kde.sh` is the entrypoint and calls `layer2/apply-kde.sh`.
It deploys `~/.config/fcitx5/conf/hotkey.conf`, sets Caps Lock/Ctrl swap, and applies BreezeDark.

GNOME 関連パッケージを削除:

```bash
./layer2/remove-gnome.sh
```

検証:
- `kreadconfig6 --file kxkbrc --group Layout --key Options` が `ctrl:swapcaps`
- `kreadconfig6 --file kdeglobals --group General --key ColorScheme` が `BreezeDark`
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
