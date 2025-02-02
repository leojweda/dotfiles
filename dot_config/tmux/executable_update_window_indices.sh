# Get the current window index
current_index=$(tmux display-message -p -F "#{window_index}")

# Compute the previous and next window indices
previous_index=$((current_index - 1))

tmux set -g @TMUX_PREVIOUS_WINDOW_INDEX "$previous_index"
