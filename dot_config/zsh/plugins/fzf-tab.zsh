# Must be loaded after zsh-completions, but before zsh-syntax-highlighting and zsh-autosuggestions.
zinit light Aloxaf/fzf-tab

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

fzf_default_opts="$(tr '\n' ' ' < "$FZF_DEFAULT_OPTS_FILE")"
zstyle ':fzf-tab:*' fzf-flags ${(s: :)fzf_default_opts}
