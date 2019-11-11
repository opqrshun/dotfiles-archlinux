#!/bin/bash
DOTPATH=$PWD

for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
    
done

ln -s ~/Dropbox/mydev/ansible/ansible/ ~/ansible
ln -s ~/Dropbox/mydev/ ~/mydev
ln -s ~/Dropbox/mydev/docker ~/mydocker
ln -s ~/Dropbox/mydev/project ~/myproject
ln -s ~/Dropbox/mydev/auto_tools ~/auto_tools
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

