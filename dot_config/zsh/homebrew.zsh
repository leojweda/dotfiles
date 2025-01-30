export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/brew/Brewfile"

if [[ $OSTYPE == linux* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Homebrew Command Not Found
HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER";
fi
