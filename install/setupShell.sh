#!/usr/bin/env bash

function setupZsh() {
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    chsh -s /bin/zsh

    # install pure prompt
    yarn global add pure-prompt
}


function setupTmux() {
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

setupZsh
setupTmux