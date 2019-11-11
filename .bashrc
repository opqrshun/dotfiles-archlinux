# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

alias ..='cd ..'
alias ld='ls -ld'          # Show info about the directory
alias lla='ls -lAF'        # Show hidden all files
alias ll='ls -lF'          # Show long file information
alias l='ls -1F'          # Show long file information
alias la='ls -AF'          # Show hidden files
alias lx='ls -lXB'         # Sort by extension
alias lk='ls -lSr'         # Sort by size, biggest last
alias lc='ls -ltcr'        # Sort by and show change time, most recent last
alias lu='ls -ltur'        # Sort by and show access time, most recent last
alias lt='ls -ltr'         # Sort by date, most recent last
alias lr='ls -lR'          # Recursive ls


alias cp="cp -i"
alias mv="mv -i"

alias pydev="source ~/venv/pydev/bin/activate"

# export PATH="$HOME/.cargo/bin:$PATH"
# export GDK_SCALE=1
# export GDK_DPI_SCALE=1.5

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
PATH="$HOME/.local/bin:$HOME/bin:$HOME/.node_modules/bin:$HOME/.yarn/bin:$HOME/.cargo/bin:$PATH"
export PATH
export SYSTEMD_LESS=FRXMK # jounalctl less
alias pydev="source ~/venv/pydev/bin/activate"
