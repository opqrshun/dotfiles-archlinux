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

layer2

```
./layer2/install.sh
```

Layer2 clones/updates and runs:
- `https://github.com/opqrshun/dotfiles-shell.git` (`install.sh`)

Override source with env vars:
- `LAYER2_SHELL_REPO_URL`
- `LAYER2_SHELL_REPO_DIR`
- `LAYER2_SHELL_REPO_REF` (default: `master`)
