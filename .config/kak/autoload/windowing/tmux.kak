# This script provides support for the tmux terminal multiplexer.
# https://github.com/tmux/tmux
declare-option str other_clients_completion %{
  echo "$kak_client_list" | tr ' ' '\n' | grep -Fxv "$kak_client"
}

declare-user-mode tmux
declare-user-mode tmux_new_split_scratch_buffer

define-command enter_tmux_mode %{
  enter-user-mode tmux
}

define-command enter_tmux_new_split_scratch_buffer_mode %{
  enter-user-mode tmux_new_split_scratch_buffer
}

define-command tmux -params 1.. %{
  nop %sh{
    TMUX=$kak_client_env_TMUX TMUX_PANE=$kak_client_env_TMUX_PANE nohup tmux set-environment kak_session "$kak_session" ';' set-environment kak_client "$kak_client" ';' "$@" < /dev/null > /dev/null 2>&1 &
  }
}

define-command jump_view_left_with_tmux %{
  tmux select-pane -L
}

define-command jump_view_down_with_tmux %{
  tmux select-pane -D
}

define-command jump_view_up_with_tmux %{
  tmux select-pane -U
}

define-command jump_view_right_with_tmux %{
  tmux select-pane -R
}

define-command swap_view_left_with_tmux %{
  tmux swap-pane -s '{left-of}'
}

define-command swap_view_down_with_tmux %{
  tmux swap-pane -s '{down-of}'
}

define-command swap_view_up_with_tmux %{
  tmux swap-pane -s '{up-of}'
}

define-command swap_view_right_with_tmux %{
  tmux swap-pane -s '{right-of}'
}

define-command shrink_viewport_right_with_tmux %{
  tmux resize-pane -L 5
}

define-command grow_viewport_down_with_tmux %{
  tmux resize-pane -D 2
}

define-command shrink_viewport_down_with_tmux %{
  tmux resize-pane -U 2
}

define-command grow_viewport_right_with_tmux %{
  tmux resize-pane -R 5
}

define-command toggle_fullscreen_with_tmux %{
  tmux resize-pane -Z
}

define-command split_view_down_with_tmux -params .. %{
  tmux split-window -v kak -c %val{session} -e %exp{
    grab_buffer_in_viewport %val{client}
    %arg{@}
  }
}

define-command split_view_right_with_tmux -params .. %{
  tmux split-window -h kak -c %val{session} -e %exp{
    grab_buffer_in_viewport %val{client}
    %arg{@}
  }
}

define-command create_view_in_new_window_with_tmux -params .. %{
  tmux new-window -a kak -c %val{session} -e %exp{
    grab_buffer_in_viewport %val{client}
    %arg{@}
  }
}

define-command move_view_to_new_window_with_tmux %{
  tmux break-pane -a
}

define-command focus_next_viewport_with_tmux %{
  tmux select-pane -t '{next}'
}

define-command focus_previous_viewport_with_tmux %{
  tmux select-pane -t '{previous}'
}

define-command focus_next_window_with_tmux %{
  tmux next-window
}

define-command focus_previous_window_with_tmux %{
  tmux previous-window
}

define-command close_view_with_tmux %{
  tmux kill-pane
}

define-command close_other_viewports_with_tmux %{
  tmux kill-pane -a
}

define-command focus_client_with_tmux -params 1 %{
  evaluate-commands -client %arg{1} %{
    tmux switch-client -t %val{client_env_TMUX_PANE}
  }
}

define-command open_prompt_focus_client_with_tmux %{
  prompt -menu client_picker: -shell-script-candidates %opt{other_clients_completion} %{
    focus_client_with_tmux %val{text}
  }
}

define-command select_view_with_tmux %{
  choose_pane_with_tmux %{
    select-pane -t '%%'
  }
}

define-command select_window_with_tmux %{
  choose_window_with_tmux %{
    switch-client -t '%%'
  }
}

define-command move_view_to_window_with_tmux_menu %{
  choose_window_with_tmux %{
    join-pane -t '%%'
  }
}

define-command choose_pane_with_tmux -params .. %{
  tmux display-panes -d 0 %arg{@}
}

define-command choose_window_with_tmux -params .. %{
  tmux run-shell %exp{
    tmux choose-tree -Zw -f '##{==:##{session_name},#{session_name}}' "%arg{@}"
  }
}

complete-command split_view_down_with_tmux command
complete-command split_view_right_with_tmux command
complete-command create_view_in_new_window_with_tmux command

map -docstring 'jump view left' global tmux h ':jump_view_left_with_tmux<ret>'
map -docstring 'jump view down' global tmux j ':jump_view_down_with_tmux<ret>'
map -docstring 'jump view up' global tmux k ':jump_view_up_with_tmux<ret>'
map -docstring 'jump view right' global tmux l ':jump_view_right_with_tmux<ret>'

map -docstring 'swap view left' global tmux H ':swap_view_left_with_tmux<ret>'
map -docstring 'swap view down' global tmux J ':swap_view_down_with_tmux<ret>'
map -docstring 'swap view up' global tmux K ':swap_view_up_with_tmux<ret>'
map -docstring 'swap view right' global tmux L ':swap_view_right_with_tmux<ret>'

map -docstring 'shrink viewport right and reenter tmux mode' global tmux <lt> ':shrink_viewport_right_with_tmux; enter_tmux_mode<ret>'
map -docstring 'grow viewport down and reenter tmux mode' global tmux <plus> ':grow_viewport_down_with_tmux; enter_tmux_mode<ret>'
map -docstring 'shrink viewport down and reenter tmux mode' global tmux <minus> ':shrink_viewport_down_with_tmux; enter_tmux_mode<ret>'
map -docstring 'grow viewport right and reenter tmux mode' global tmux <gt> ':grow_viewport_right_with_tmux; enter_tmux_mode<ret>'

map -docstring 'toggle fullscreen' global tmux f ':toggle_fullscreen_with_tmux<ret>'

map -docstring 'split view down' global tmux o ':split_view_down_with_tmux<ret>'
map -docstring 'split view right' global tmux O ':split_view_right_with_tmux<ret>'

map -docstring 'create view in new window' global tmux c ':create_view_in_new_window_with_tmux<ret>'
map -docstring 'move view to new window' global tmux T ':move_view_to_new_window_with_tmux<ret>'

map -docstring 'focus next viewport' global tmux w ':focus_next_viewport_with_tmux<ret>'
map -docstring 'focus previous viewport' global tmux W ':focus_previous_viewport_with_tmux<ret>'

# map -docstring 'focus next window' global tmux n ':focus_next_window_with_tmux<ret>'
# map -docstring 'focus previous window' global tmux p ':focus_previous_window_with_tmux<ret>'

map -docstring 'close view' global tmux x ':close_view_with_tmux<ret>'
map -docstring 'close other viewports' global tmux X ':close_other_viewports_with_tmux<ret>'

map -docstring 'open prompt focus client' global tmux / ':open_prompt_focus_client_with_tmux<ret>'
map -docstring 'select view' global tmux q ':select_view_with_tmux<ret>'
map -docstring 'select window' global tmux s ':select_window_with_tmux<ret>'
map -docstring 'move view to window' global tmux m ':move_view_to_window_with_tmux_menu<ret>'

map -docstring 'new split scratch buffer' global tmux n ':enter_tmux_new_split_scratch_buffer_mode<ret>'

map -docstring 'split view down with new scratch buffer' global tmux_new_split_scratch_buffer o ':split_view_down_with_tmux edit -scratch<ret>'
map -docstring 'split view right with new scratch buffer' global tmux_new_split_scratch_buffer O ':split_view_right_with_tmux edit -scratch<ret>'

map -docstring 'jump view left' global tmux <c-h> ':jump_view_left_with_tmux<ret>'
map -docstring 'jump view down' global tmux <c-j> ':jump_view_down_with_tmux<ret>'
map -docstring 'jump view up' global tmux <c-k> ':jump_view_up_with_tmux<ret>'
map -docstring 'jump view right' global tmux <c-l> ':jump_view_right_with_tmux<ret>'

map -docstring 'split view down' global tmux <c-s> ':split_view_down_with_tmux<ret>'
map -docstring 'split view right' global tmux <c-v> ':split_view_right_with_tmux<ret>'

map -docstring 'focus next viewport' global tmux <c-w> ':focus_next_viewport_with_tmux<ret>'

map -docstring 'close view' global tmux <c-q> ':close_view_with_tmux<ret>'
map -docstring 'close other viewports' global tmux <c-o> ':close_other_viewports_with_tmux<ret>'

map -docstring 'new split scratch buffer' global tmux <c-n> ':enter_tmux_new_split_scratch_buffer_mode<ret>'
