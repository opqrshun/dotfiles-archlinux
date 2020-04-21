# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export LC_ALL=en_US.UTF-8
export TERMINAL=alacritty
export PAGER=less
export VISUAL=nvim
export EDITOR='nvim'
export RANGER_LOAD_DEFAULT_RC=FALSE

# Node.js
PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules

# PIP
export PATH=$HOME/.local/bin:$PATH

# Go
export PATH="$PATH:$HOME/go/bin"


