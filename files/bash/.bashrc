# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Enable bash completion if available
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# Ensure ~/.local/bin and ~/bin are in PATH (colon-guarded contains check)
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  PATH="$HOME/.local/bin:$PATH"
fi
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
  PATH="$HOME/bin:$PATH"
fi
export PATH

# Source per-file snippets from ~/.bashrc.d
if [[ -d "$HOME/.bashrc.d" ]]; then
  for rc in "$HOME"/.bashrc.d/*; do
    if [[ -f "$rc" ]]; then
      . "$rc"
    fi
  done
fi
unset rc

# direnv hook (only if installed)
if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

# Our aliases
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# Our secrets (not deployed — sourced if present)
if [ -f ~/.secrets ]; then
    source ~/.secrets
fi

# Our functions
if [ -f ~/.functions ]; then
    source ~/.functions
fi

# Our exports
if [ -f ~/.exports ]; then
    source ~/.exports
fi

# Set vim keybindings
set -o vi

# Custom prompt: show virtualenv if active, user@host:path in colors
PS1='${VIRTUAL_ENV:+(\[\033[01;33m\]$(basename $VIRTUAL_ENV)\[\033[00m\]) }\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
