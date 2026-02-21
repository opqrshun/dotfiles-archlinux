# Layer2 minimal zsh environment

# User-local binaries
path=(
  "$HOME/.local/bin"
  "$HOME/.node_modules/bin"
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  "$HOME/n/bin"
  "$HOME/.usp/bin"
  $path
)
export PATH

export npm_config_prefix="$HOME/.node_modules"
