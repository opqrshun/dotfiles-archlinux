# Layer2 minimal interactive zsh config

# fzf integrations (if installed)
if [ -n "${commands[fzf-share]:-}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
elif [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
elif [ -f "$HOME/.fzf.zsh" ]; then
  source "$HOME/.fzf.zsh"
fi

# Optional per-user extensions
if [[ -s "$HOME/.zcustom" ]]; then
  source "$HOME/.zcustom"
fi
if [[ -s "$HOME/.zspecial" ]]; then
  source "$HOME/.zspecial"
fi
if [[ -f "$HOME/.z_lib/z/z.sh" ]]; then
  source "$HOME/.z_lib/z/z.sh"
fi

# tmux terminal fix
if [[ -n "${TMUX:-}" && -n "${commands[tmux]:-}" ]]; then
  export TERM=screen-256color
fi

# Minimal aliases
alias ...='cd ../..'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias ip='ip -c'
alias rm='rm -i'
alias vim='nvim'
alias v='nvim'
alias relogin='exec $SHELL -l'

if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi
