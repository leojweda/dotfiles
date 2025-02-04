#!/bin/zsh

status_bar_background_color=$tmux_background_highlight_color

is_first_window="#{==:#{window_index},1}"
is_last_window="#{==:#{window_index},#{session_windows}}"

tmux set -g status-style bg=${status_bar_background_color}

status_bar_left_background_color=$tmux_background_color
status_bar_left_content="#[fg=${tmux_text_color},bg=${status_bar_left_background_color}] #S:#I.#P "
status_bar_left_suffix="#[fg=${status_bar_left_background_color},bg=${status_bar_background_color}]"
tmux set -g status-left "${status_bar_left_content}${status_bar_left_suffix}"

window_background_color=$status_bar_background_color
window_separator_color=$tmux_background_color
is_next_window_active="#{==:#{window_index},#{@TMUX_PREVIOUS_WINDOW_INDEX}}"
window_prefix="#[fg=${window_separator_color},bg=${window_background_color}]#{?${is_first_window},,}"
window_content="#[fg=${tmux_text_color},bg=${window_background_color}] #I#F #W"
window_suffix="#[fg=${window_separator_color},bg=${window_background_color}]#{?${is_next_window_active},,}"
tmux setw -g window-status-format "${window_prefix}${window_content}${window_suffix}"

current_window_background_color=$tmux_background_color
curent_window_first_window_prefix="#[fg=${status_bar_background_color}]#[bg=${current_window_background_color}]"
current_window_other_window_prefix="#[fg=${window_background_color}]#[bg=${current_window_background_color}]"
current_window_prefix="#{?${is_first_window},${curent_window_first_window_prefix},${current_window_other_window_prefix}}"
current_window_content="#[fg=${tmux_text_color},bg=${current_window_background_color}] #I#F #W "
current_window_suffix="#[fg=${current_window_background_color}]#[bg=${window_background_color}]"
tmux setw -g window-status-current-format "${current_window_prefix}${current_window_content}${current_window_suffix}"

leader_key_indicator_color='blue'
is_leader_key_pressed="client_prefix"

if [[ -n $SSH_CONNECTION ]]; then
    status_right_background_color='color136'
    status_rightforeground_color='color230'

    leader_key_pressed_suffix="#[fg=${leader_key_indicator_color}]#[bg=${status_bar_background_color}]#[fg=${tmux_background_color}]#[bg=${leader_key_indicator_color}]^; #[fg=${status_right_background_color}]#[bg=${leader_key_indicator_color}]"
    leader_key_not_pressed_suffix="#[fg=${status_right_background_color}]#[bg=${status_bar_background_color}]"
    status_bar_right_suffix="#{?${is_leader_key_pressed},${leader_key_pressed_suffix},${leader_key_not_pressed_suffix}}"
    status_bar_right_content="#[fg=${status_rightforeground_color},bg=${status_right_background_color}] #(whoami)@#H "
    tmux set -g status-right "${status_bar_right_suffix}${status_bar_right_content}"
else
    leader_key_pressed_content="#[fg=${leader_key_indicator_color}]#[bg=${status_bar_background_color}]#[fg=${tmux_background_color}]#[bg=${leader_key_indicator_color}]^; "
    tmux set -g status-right "#{?${is_leader_key_pressed},${leader_key_pressed_content},}"
fi
