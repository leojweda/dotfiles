# Must be loaded after history-substring-search, autosuggestions, and augosuggestions.
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ${XDG_CONFIG_HOME}/ohmyposh/base.json)"
fi

function set_poshcontext() {
  export BG_JOBS=$(jobs|wc -l|xargs)
}
