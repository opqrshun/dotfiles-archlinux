#!/usr/bin/env bash

DOTFILES=$HOME/.dotfiles

echo -e "\\nCreating symlinks"
echo "=============================="
linkables=$( find -H "$DOTFILES" -maxdepth 1 -name '.*' -not -name '.git*')
for file in $linkables ; do
    target="$HOME/$( basename "$file")"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $file"
        ln -s "$file" "$target"
    fi
done

echo -e "\\n\\ninstalling to ~/.config"
echo "=============================="
if [ ! -d "$HOME/.config" ]; then
    echo "Creating ~/.config"
    mkdir -p "$HOME/.config"
fi

config_files=$( find "$DOTFILES/.config" -maxdepth 4 2>/dev/null )
for config in $config_files; do
    target="${HOME}${config#$DOTFILES}"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $config"
        ln -s "$config" "$target"
    fi
done



# echo -e "\\n\\nCreating vim symlinks"
# echo "=============================="
# VIMFILES=( "$HOME/.vim:$DOTFILES/config/nvim"
#         "$HOME/.vimrc:$DOTFILES/config/nvim/init.vim" )

# for file in "${VIMFILES[@]}"; do
#     KEY=${file%%:*}
#     VALUE=${file#*:}
#     if [ -e "${KEY}" ]; then
#         echo "${KEY} already exists... skipping."
#     else
#         echo "Creating symlink for $KEY"
#         ln -s "${VALUE}" "${KEY}"
#     fi
# done
