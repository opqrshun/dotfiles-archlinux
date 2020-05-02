# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure


source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/z/z.sh

# Aliases
alias sortmirror='sudo reflector --latest 200 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias ip='ip -c'
alias rm='rm -i'
alias f='ranger'
alias c='cmus'
alias h='htop'
alias vi='nvim'
alias vim='nvim'
alias cat='bat'
alias relogin='exec $SHELL -l'
# Show OS info when opening a new terminal
neofetch

