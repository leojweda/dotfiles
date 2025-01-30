# Created by `pipx` on 2025-01-21 19:37:58
export PATH="$PATH:/Users/leojweda/.local/bin"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

export VISUAL='code'

HISTFILE="$XDG_DATA_HOME/zsh/history"
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

SHELL_SESSIONS_DISABLE=1
