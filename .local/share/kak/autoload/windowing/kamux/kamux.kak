# name: kakoune_kamux
# version: 0.1.0
# description: This script provides support for the kamux terminal multiplexer.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["nohup", "grab_buffer_in_viewport"]
# doc: yes
# tests: no
define-command kamux -params 1.. %{
  nohup env "TMUX=%val{client_env_TMUX}" "TMUX_PANE=%val{client_env_TMUX_PANE}" tmux %arg{@}
}

define-command kamux_jump_view_left %{
  kamux select-pane -L
}

define-command kamux_jump_view_down %{
  kamux select-pane -D
}

define-command kamux_jump_view_up %{
  kamux select-pane -U
}

define-command kamux_jump_view_right %{
  kamux select-pane -R
}

define-command kamux_swap_view_left %{
  kamux swap-pane -s '{left-of}'
}

define-command kamux_swap_view_down %{
  kamux swap-pane -s '{down-of}'
}

define-command kamux_swap_view_up %{
  kamux swap-pane -s '{up-of}'
}

define-command kamux_swap_view_right %{
  kamux swap-pane -s '{right-of}'
}

define-command kamux_shrink_viewport_right %{
  kamux resize-pane -L 5
}

define-command kamux_grow_viewport_down %{
  kamux resize-pane -D 2
}

define-command kamux_shrink_viewport_down %{
  kamux resize-pane -U 2
}

define-command kamux_grow_viewport_right %{
  kamux resize-pane -R 5
}

define-command kamux_toggle_fullscreen %{
  kamux resize-pane -Z
}

define-command kamux_split_view_down -params .. %{
  kamux split-window -v kak -c %val{session} -e %exp{
    grab_buffer_in_viewport %val{client}
    %arg{@}
  }
}

define-command kamux_split_view_right -params .. %{
  kamux split-window -h kak -c %val{session} -e %exp{
    grab_buffer_in_viewport %val{client}
    %arg{@}
  }
}

define-command kamux_create_view_in_new_window -params .. %{
  kamux new-window kak -c %val{session} -e %exp{
    grab_buffer_in_viewport %val{client}
    %arg{@}
  }
}

define-command kamux_create_view_in_new_window_right -params .. %{
  kamux new-window -a kak -c %val{session} -e %exp{
    grab_buffer_in_viewport %val{client}
    %arg{@}
  }
}

define-command kamux_move_view_to_new_window %{
  kamux break-pane -a
}

define-command kamux_activate_next_viewport %{
  kamux select-pane -t '{next}'
}

define-command kamux_activate_previous_viewport %{
  kamux select-pane -t '{previous}'
}

define-command kamux_activate_next_window %{
  kamux next-window
}

define-command kamux_activate_previous_window %{
  kamux previous-window
}

define-command kamux_activate_window_by_index -params 1 %{
  kamux select-window -t %arg{1}
}

define-command kamux_activate_first_window %{
  kamux_activate_window_by_index 1
}

define-command kamux_activate_second_window %{
  kamux_activate_window_by_index 2
}

define-command kamux_activate_third_window %{
  kamux_activate_window_by_index 3
}

define-command kamux_activate_fourth_window %{
  kamux_activate_window_by_index 4
}

define-command kamux_activate_fifth_window %{
  kamux_activate_window_by_index 5
}

define-command kamux_activate_sixth_window %{
  kamux_activate_window_by_index 6
}

define-command kamux_activate_seventh_window %{
  kamux_activate_window_by_index 7
}

define-command kamux_activate_eighth_window %{
  kamux_activate_window_by_index 8
}

define-command kamux_activate_last_window %{
  kamux_activate_window_by_index '#{last_window_index}'
}

define-command kamux_move_window_left %{
  kamux swap-window -t :-1 ';' previous-window
}

define-command kamux_move_window_right %{
  kamux swap-window -t :+1 ';' next-window
}

define-command kamux_close_view %{
  kamux kill-pane
}

define-command kamux_close_other_viewports %{
  kamux kill-pane -a
}

define-command kamux_close_window %{
  kamux kill-window
}

define-command kamux_close_other_windows %{
  kamux kill-window -a
}

define-command kamux_activate_view -params 1 %{
  evaluate-commands -client %arg{1} %{
    kamux switch-client -t %val{client_env_TMUX_PANE}
  }
}

define-command kamux_search_view %{
  prompt -menu client_picker: -shell-script-candidates -client-completion %{
    kamux_activate_view %val{text}
  }
}

define-command kamux_select_view %{
  kamux_activate_pane_select %{
    select-pane -t '%%'
  }
}

define-command kamux_select_window %{
  kamux_activate_window_select %{
    switch-client -t '%%'
  }
}

define-command kamux_move_view_to_window_window_select %{
  kamux_activate_window_select %{
    join-pane -t '%%'
  }
}

define-command kamux_activate_pane_select -params .. %{
  kamux display-panes -d 0 %arg{@}
}

define-command kamux_activate_window_select -params .. %{
  kamux run-shell %exp{
    kamux choose-tree -Zw -f '##{==:##{session_name},#{session_name}}' "%arg{@}"
  }
}

complete-command kamux_split_view_down command
complete-command kamux_split_view_right command
complete-command kamux_create_view_in_new_window command
complete-command kamux_create_view_in_new_window_right command
complete-command kamux_activate_view client
