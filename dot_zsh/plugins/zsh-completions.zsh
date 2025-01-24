zinit light zsh-users/zsh-completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# TODO: Make the colours match the colours in eza.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
