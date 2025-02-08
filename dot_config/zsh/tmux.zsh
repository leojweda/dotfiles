if [[ -z "$TMUX" && -z "$EMACS" && -z "$INSIDE_EMACS" && -z "$VIM" && -z "$VSCODE_RESOLVING_ENVIRONMENT" && "$TERM_PROGRAM" != "vscode" && "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]]; then
  tmux attach -t default || tmux new -s default
fi
