# Must be loaded before appearance.zsh and plugins.zsh.
# Created by `pipx` on 2025-01-21 19:37:58
export PATH="$PATH:/Users/leojweda/.local/bin"

export PATH="$(brew --prefix)/opt/python@3/libexec/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

export VISUAL='code'

export BAT_CONFIG_DIR="${XDG_CONFIG_HOME}/bat"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt HIST_BEEP

setopt INTERACTIVE_COMMENTS

typeset -A ZSH_HIGHLIGHT_STYLES
