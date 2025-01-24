# Must be loaded before history-substring-search, autosuggestions, and the prompt.
zinit light zsh-users/zsh-syntax-highlighting

ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=green'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=166'
ZSH_HIGHLIGHT_STYLES[function]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='fg=blue,underline'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=61'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=61'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=red,underline'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=red,underline'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=red,underline'
