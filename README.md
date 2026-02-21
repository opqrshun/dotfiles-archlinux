# dotfiles-archlinux-2


layer1

```
bash <(curl -fsSL https://raw.githubusercontent.com/opqrshun/dotfiles-archlinux-2/dev/bootstrap.sh)
```

```
BOOTSTRAP_INSTALL_YAY=1 \
BOOTSTRAP_INSTALL_CHROME=1 \
BOOTSTRAP_INSTALL_VSCODE=1 \
BOOTSTRAP_INSTALL_SHELL_AUR=1 \
bash <(curl -fsSL https://raw.githubusercontent.com/opqrshun/dotfiles-archlinux-2/dev/bootstrap.sh)
```

Install all configured AUR packages at once:

```
BOOTSTRAP_INSTALL_AUR_ALL=1 \
bash <(curl -fsSL https://raw.githubusercontent.com/opqrshun/dotfiles-archlinux-2/dev/bootstrap.sh)
```

layer2 (manual)

```bash
rm -f ~/.dotfiles-shell
git clone https://github.com/opqrshun/dotfiles-shell.git ~/.dotfiles-shell
bash ~/.dotfiles-shell/install.sh
```

Check `.zshrc` link target:

```bash
readlink ~/.zshrc
```
