# name: kakoune_tmux
# version: 0.1.0
# description: This script provides support for the tmux terminal multiplexer.
# description: Kamux comes an integrated terminal emulator that uses tmux as its backend.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["nohup", "grab-buffer"]
# doc: yes
# tests: no
def tmux -params 1.. %{
  nohup env "TMUX=%val{client_env_TMUX}" "TMUX_PANE=%val{client_env_TMUX_PANE}" tmux %arg{@}
}

def tmux_jump_view_left %{
  tmux select-pane -L
}

def tmux_jump_view_down %{
  tmux select-pane -D
}

def tmux_jump_view_up %{
  tmux select-pane -U
}

def tmux_jump_view_right %{
  tmux select-pane -R
}

def tmux_swap_view_left %{
  tmux swap-pane -s '{left-of}'
}

def tmux_swap_view_down %{
  tmux swap-pane -s '{down-of}'
}

def tmux_swap_view_up %{
  tmux swap-pane -s '{up-of}'
}

def tmux_swap_view_right %{
  tmux swap-pane -s '{right-of}'
}

def tmux_shrink_viewport_right %{
  tmux resize-pane -L 5
}

def tmux_grow_viewport_down %{
  tmux resize-pane -D 2
}

def tmux_shrink_viewport_down %{
  tmux resize-pane -U 2
}

def tmux_grow_viewport_right %{
  tmux resize-pane -R 5
}

def tmux_toggle_fullscreen %{
  tmux resize-pane -Z
}

def tmux_split_view_down -params .. %{
  tmux split-window -v kak -c %val{session} -e %exp{
    grab-buffer %val{client}
    %arg{@}
  }
}

def tmux_split_view_right -params .. %{
  tmux split-window -h kak -c %val{session} -e %exp{
    grab-buffer %val{client}
    %arg{@}
  }
}

def tmux_create_view_in_new_window -params .. %{
  tmux new-window kak -c %val{session} -e %exp{
    grab-buffer %val{client}
    %arg{@}
  }
}

def tmux_create_view_in_new_window_right -params .. %{
  tmux new-window -a kak -c %val{session} -e %exp{
    grab-buffer %val{client}
    %arg{@}
  }
}

def tmux_move_view_to_new_window %{
  tmux break-pane -a
}

def tmux_activate_next_viewport %{
  tmux select-pane -t '{next}'
}

def tmux_activate_previous_viewport %{
  tmux select-pane -t '{previous}'
}

def tmux_activate_next_window %{
  tmux next-window
}

def tmux_activate_previous_window %{
  tmux previous-window
}

def tmux_activate_window_by_index -params 1 %{
  tmux select-window -t %arg{1}
}

def tmux_activate_first_window %{
  tmux_activate_window_by_index 1
}

def tmux_activate_second_window %{
  tmux_activate_window_by_index 2
}

def tmux_activate_third_window %{
  tmux_activate_window_by_index 3
}

def tmux_activate_fourth_window %{
  tmux_activate_window_by_index 4
}

def tmux_activate_fifth_window %{
  tmux_activate_window_by_index 5
}

def tmux_activate_sixth_window %{
  tmux_activate_window_by_index 6
}

def tmux_activate_seventh_window %{
  tmux_activate_window_by_index 7
}

def tmux_activate_eighth_window %{
  tmux_activate_window_by_index 8
}

def tmux_activate_last_window %{
  tmux_activate_window_by_index '#{last_window_index}'
}

def tmux_move_window_left %{
  tmux swap-window -t :-1 ';' previous-window
}

def tmux_move_window_right %{
  tmux swap-window -t :+1 ';' next-window
}

def tmux_close_view %{
  tmux kill-pane
}

def tmux_close_other_viewports %{
  tmux kill-pane -a
}

def tmux_close_window %{
  tmux kill-window
}

def tmux_close_other_windows %{
  tmux kill-window -a
}

def tmux_activate_view -params 1 %{
  evaluate-commands -client %arg{1} %{
    tmux switch-client -t %val{client_env_TMUX_PANE}
  }
}

def tmux_search_view %{
  prompt -menu client_picker: -client-completion %{
    tmux_activate_view %val{text}
  }
}

def tmux_select_view %{
  tmux_activate_pane_select %{
    select-pane -t '%%'
  }
}

def tmux_select_window %{
  tmux_activate_window_select %{
    switch-client -t '%%'
  }
}

def tmux_move_view_to_window_window_select %{
  tmux_activate_window_select %{
    join-pane -t '%%'
  }
}

def tmux_activate_pane_select -params .. %{
  tmux display-panes -d 0 %arg{@}
}

def tmux_activate_window_select -params .. %{
  tmux run-shell %exp{
    tmux choose-tree -Zw -f '##{==:##{session_name},#{session_name}}' "%arg{@}"
  }
}

compl tmux_split_view_down command
compl tmux_split_view_right command
compl tmux_create_view_in_new_window command
compl tmux_create_view_in_new_window_right command
compl tmux_activate_view client
