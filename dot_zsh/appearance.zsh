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
    new_interface_style=$(get_interface_style)

    if [[ $INTERFACE_STYLE != $new_interface_style ]]; then
      export INTERFACE_STYLE=$new_interface_style

      if [[ $INTERFACE_STYLE == 'dark' ]]; then
        # Ghostty
        old_background_color='FDF6E2'
        new_background_color='002B35'
      else
        # Ghostty
        old_background_color='002B35'
        new_background_color='FDF6E2'
      fi

      # Update Ghostty configuration
      sed -i '' "s/^background = ${old_background_color}/#background = ${old_background_color}/" "${XDG_CONFIG_HOME}/ghostty/config"
      sed -i '' "s/^#background = ${new_background_color}/background = ${new_background_color}/" "${XDG_CONFIG_HOME}/ghostty/config"
    fi

    # Use interface style as appearance on macOS
    export APPEARANCE=$INTERFACE_STYLE
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

    # Tmux
    tmux_background_highlight_color='black'
    tmux_background_color='brightblack'
    tmux_text_color='brightblue'
    tmux_optional_text_color='brightgreen'

    # nano
    nano_body_text_color='lightblue'
    nano_comment_color='lightgreen'
    nano_emphasized_color='lightcyan'
    nano_background_highlight_color='black'
  else
    # Zsh Syntax Highlighting
    zsh_comment_color='245'

    # Tmux
    tmux_background_highlight_color='white'
    tmux_background_color='brightwhite'
    tmux_text_color='brightyellow'
    tmux_optional_text_color='brightcyan'

    # nano
    nano_body_text_color='lightyellow'
    nano_comment_color='lightcyan'
    nano_emphasized_color='lightgreen'
    nano_background_highlight_color='white'
  fi

  ZSH_HIGHLIGHT_STYLES[comment]="fg=${zsh_comment_color}"

  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${zsh_comment_color}"

  if [ -n "$TMUX" ]; then
    status_bar_background_color=$tmux_background_highlight_color

    tmux set -g status-style bg=${status_bar_background_color}

    status_bar_left_content="#[fg=${tmux_text_color},bg=${tmux_background_color}] #S:#I.#P "
    status_bar_left_suffix="#[fg=${tmux_background_color},bg=${status_bar_background_color}]"
    tmux set -g status-left "${status_bar_left_content}${status_bar_left_suffix}"

    window_prefix="#[fg=${status_bar_background_color},bg=${tmux_background_color}]#{?#{==:#{window_index},1},,}"
    window_content="#[fg=${tmux_text_color},bg=${tmux_background_color}] #I#F #W"
    window_suffix="#[fg=${tmux_background_color},bg=${status_bar_background_color}]#{?#{==:#{window_index},#{session_windows}},,}"
    tmux setw -g window-status-format "${window_prefix}${window_content}${window_suffix}"

    current_window_prefix="#[fg=${tmux_background_highlight_color},bg=${tmux_background_color}]#{?#{==:#{window_index},1},,}#[fg=${tmux_background_color},bg=${status_bar_background_color}]#{?#{==:#{window_index},1},,}"
    current_window_content="#[fg=${tmux_text_color},bg=${tmux_background_highlight_color}] #I#F #W "
    current_window_suffix="#{?#{==:#{window_index},#{session_windows}},#[fg=${tmux_background_color}]#[bg=${status_bar_background_color}],#[fg=${tmux_background_highlight_color}]#[bg=${tmux_background_color}]}"
    tmux setw -g window-status-current-format "${current_window_prefix}${current_window_content}${current_window_suffix}"

    if [[ -n $SSH_CONNECTION ]]; then
      status_right_session_background_color='color136'
      status_right_session_foreground_color='color230'

      status_right_session_suffix="#[fg=${status_right_session_background_color},bg=${status_bar_background_color}]"
      status_right_session="#[fg=${status_right_session_foreground_color},bg=${status_right_session_background_color}] #(whoami)@#H "
      tmux set -g status-right "${status_right_session_suffix}${status_right_session}"
    else
      tmux set -g status-right ""
    fi
  fi

  sed -i '' "s|^set keycolor .*|set keycolor ${nano_body_text_color},${nano_background_highlight_color}|" "${XDG_CONFIG_HOME}/nano/nanorc"
  sed -i '' "s|^set numbercolor .*|set numbercolor ${nano_comment_color},${nano_background_highlight_color}|" "${XDG_CONFIG_HOME}/nano/nanorc"
  sed -i '' "s|^set titlecolor .*|set titlecolor ${nano_emphasized_color},${nano_background_highlight_color}|" "${XDG_CONFIG_HOME}/nano/nanorc"
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

[[ $- == *i* ]] && update_appearance

# Hook into Zsh's `precmd` to check and update the interface style before each prompt
precmd_functions+=(update_appearance)
