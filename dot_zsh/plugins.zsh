export PLUGINS_DIR="$HOME/.zsh/plugins"

source "$PLUGINS_DIR/zsh-completions.zsh"
# Must be loaded after zsh-completions.
source "$PLUGINS_DIR/fzf-tab.zsh"
# Must be loaded before history-substring-search, autosuggestions, and the prompt.
source "$PLUGINS_DIR/zsh-syntax-highlighting.zsh"
