export PLUGINS_DIR="$HOME/.zsh/plugins"

source "$PLUGINS_DIR/zsh-completions.zsh"
# Must be loaded after zsh-completions.
source "$PLUGINS_DIR/fzf-tab.zsh"
# Must be loaded before history-substring-search, autosuggestions, and the prompt.
source "$PLUGINS_DIR/zsh-syntax-highlighting.zsh"
# Must be loaded after syntax-highlighting, but before augosuggestions and the prompt.
source "$PLUGINS_DIR/zsh-history-substring-search.zsh"
# Must be loaded after syntax-highlighting and history-substring-search, but before the prompt.
source "$PLUGINS_DIR/zsh-autosuggestions.zsh"
