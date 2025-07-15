if [ ! -f /.dockerenv ]; then
  docker completion zsh > $XDG_DATA_HOME/zinit/completions/_docker
fi
