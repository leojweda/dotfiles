zinit light zsh-users/zsh-completions

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# TODO: Make the colours match the colours in eza.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Must be loaded after zsh-completions.
autoload -U compinit

_comp_files=($XDG_CACHE_HOME/zsh/zcompcache(Nm-20))
if (( $#_comp_files )); then
    compinit -i -C -d "$XDG_CACHE_HOME/zsh/zcompcache"
else
    compinit -i -d "$XDG_CACHE_HOME/zsh/zcompcache"
fi
unset _comp_files
