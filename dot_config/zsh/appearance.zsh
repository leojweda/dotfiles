# Must be loaded after plugins.zsh, but before prompt.zsh.

# Must be loaded before zsh-syntax-highlighting.

# Function to detect interface style on macOS
function get_interface_style() {
  if [[ $OSTYPE == darwin* ]]; then
    if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q "Dark"; then
      echo "dark"
    else
      echo "light"
    fi
  else
    echo ""  # Empty string for non-macOS environments
  fi
}

function update_appearance() {
  # macOS-specific logic
  if [[ $OSTYPE == darwin* ]]; then
    # Use interface style as appearance on macOS
    export APPEARANCE=$(get_interface_style)
  else
    # On non-macOS systems, require manual setup of APPEARANCE
    if [[ -z $APPEARANCE ]]; then
      echo "Error: APPEARANCE is not set. Please set it to 'light' or 'dark' manually." >&2
      return 1
    fi
  fi

  # Load vivid LS_COLORS based on APPEARANCE
  if vivid themes | grep -q "solarized-${APPEARANCE}"; then
    export LS_COLORS="$(vivid generate solarized-${APPEARANCE})"
  else
    echo "Error: Theme solarized-${APPEARANCE} not found." >&2
    return 1
  fi

  if [[ $APPEARANCE == 'dark' ]]; then
    # Zsh Syntax Highlighting
    zsh_comment_color='240'

    # nano
    nano_body_text_color='lightblue'
    nano_comment_color='lightgreen'
    nano_emphasized_color='lightcyan'
    nano_background_highlight_color='black'
  else
    # Zsh Syntax Highlighting
    zsh_comment_color='245'

    # nano
    nano_body_text_color='lightyellow'
    nano_comment_color='lightcyan'
    nano_emphasized_color='lightgreen'
    nano_background_highlight_color='white'
  fi

  ZSH_HIGHLIGHT_STYLES[comment]="fg=${zsh_comment_color}"

  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${zsh_comment_color}"

  if [ -n "$TMUX" ]; then
    source ~/.config/tmux/update_window_indices.sh
  fi

  if [[ $OSTYPE == darwin* ]]; then
    sed -i '' "s|^set keycolor .*|set keycolor ${nano_body_text_color},${nano_background_highlight_color}|" "${XDG_CONFIG_HOME}/nano/nanorc"
    sed -i '' "s|^set numbercolor .*|set numbercolor ${nano_comment_color},${nano_background_highlight_color}|" "${XDG_CONFIG_HOME}/nano/nanorc"
    sed -i '' "s|^set titlecolor .*|set titlecolor ${nano_emphasized_color},${nano_background_highlight_color}|" "${XDG_CONFIG_HOME}/nano/nanorc"
  else
    sed -i "s|^set keycolor .*|set keycolor ${nano_body_text_color},${nano_background_highlight_color}|" "${XDG_CONFIG_HOME}/nano/nanorc"
    sed -i "s|^set numbercolor .*|set numbercolor ${nano_comment_color},${nano_background_highlight_color}|" "${XDG_CONFIG_HOME}/nano/nanorc"
    sed -i "s|^set titlecolor .*|set titlecolor ${nano_emphasized_color},${nano_background_highlight_color}|" "${XDG_CONFIG_HOME}/nano/nanorc"
  fi
}

# Function to set light appearance and trigger updates
function set_light_appearance() {
  export APPEARANCE="light"
  update_appearance
}

# Function to set dark appearance and trigger updates
function set_dark_appearance() {
  export APPEARANCE="dark"
  update_appearance
}

# Call `set_light_appearance` on non-macOS systems before `update_appearance`
if [[ $OSTYPE != darwin* ]]; then
  set_dark_appearance
fi

[[ $- == *i* ]] && update_appearance

if [ -n "$TMUX" ]; then
  if [[ $APPEARANCE == 'dark' ]]; then
    tmux source-file $XDG_CONFIG_HOME/tmux/solarized/solarized-dark.conf
  else
    tmux source-file $XDG_CONFIG_HOME/tmux/solarized/solarized-light.conf
  fi
fi

# Hook into Zsh's `precmd` to check and update the interface style before each prompt
precmd_functions+=(update_appearance)
