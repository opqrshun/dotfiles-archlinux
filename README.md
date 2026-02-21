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

layer2

```
./layer2/install.sh
```

Layer2 installs minimal shell-first dotfiles:
- `~/.zshenv`
- `~/.zprofile`
- `~/.zshrc`
- `~/.tmux.conf`
