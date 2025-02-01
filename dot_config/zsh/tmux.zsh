if [[ -z "$TMUX" && -z "$INSIDE_EMACS" && -z "$EMACS" && -z "$VIM" && -z "$INTELLIJ_ENVIRONMENT_READER" && "$TERM_PROGRAM" != "vscode" ]]; then
  tmux attach -t default || tmux new -s default
fi
