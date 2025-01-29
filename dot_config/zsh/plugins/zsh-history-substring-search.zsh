# Must be loaded after syntax-highlighting, but before augosuggestions and the prompt.
zinit light 'zsh-users/zsh-history-substring-search'

# zinit ice wait atload"_history_substring_search_config"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
