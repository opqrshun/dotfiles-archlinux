# Layer2 minimal zsh login profile

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

if [[ -z "${LANG:-}" ]]; then
  export LANG='en_US.UTF-8'
fi

typeset -gU path cdpath fpath mailpath
