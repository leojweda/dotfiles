export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/homebrew/Brewfile"

if [[ $OSTYPE == darwin* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ $OSTYPE == linux* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export PATH="$(brew --prefix rustup)/bin:$(brew --prefix)/bin:$PATH"

# Homebrew Command Not Found
HOMEBREW_COMMAND_NOT_FOUND_HANDLER="$(brew --repository)/Library/Homebrew/command-not-found/handler.sh"
if [ -f "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER" ]; then
  source "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER";
fi
