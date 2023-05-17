# This script provides support for the tmux terminal multiplexer.
# https://github.com/tmux/tmux
declare-option str client_completion %{
  echo "$kak_client_list" | tr ' ' '\n' | grep -Fxv "$kak_client"
}

declare-user-mode tmux

define-command enter_tmux_mode %{
  enter-user-mode tmux
}

define-command tmux -params 1.. %{
  nop %sh{
    TMUX=$kak_client_env_TMUX TMUX_PANE=$kak_client_env_TMUX_PANE tmux set-environment kak_session "$kak_session" ';' set-environment kak_client "$kak_client" ';' "$@"
  }
}

define-command split_view_down_with_tmux_terminal -params .. %{
  tmux split-window -v -- %arg{@}
}

define-command split_view_right_with_tmux_terminal -params .. %{
  tmux split-window -h -- %arg{@}
}

define-command split_view_up_with_tmux_terminal -params .. %{
  tmux split-window -v -b -- %arg{@}
}

define-command split_view_left_with_tmux_terminal -params .. %{
  tmux split-window -h -b -- %arg{@}
}

define-command open_new_tab_with_tmux_terminal -params .. %{
  tmux new-window -- %arg{@}
}

define-command open_new_tab_right_with_tmux_terminal -params .. %{
  tmux new-window -a -- %arg{@}
}

define-command open_new_tab_left_with_tmux_terminal -params .. %{
  tmux new-window -b -- %arg{@}
}

define-command split_view_down_with_tmux -params .. %{
  split_view_down_with_tmux_terminal kak -c %val{session} -e "%arg{@}"
}

define-command split_view_right_with_tmux -params .. %{
  split_view_right_with_tmux_terminal kak -c %val{session} -e "%arg{@}"
}

define-command split_view_up_with_tmux -params .. %{
  split_view_up_with_tmux_terminal kak -c %val{session} -e "%arg{@}"
}

define-command split_view_left_with_tmux -params .. %{
  split_view_left_with_tmux_terminal kak -c %val{session} -e "%arg{@}"
}

define-command open_new_tab_with_tmux -params .. %{
  open_new_tab_with_tmux_terminal kak -c %val{session} -e "%arg{@}"
}

define-command open_new_tab_right_with_tmux -params .. %{
  open_new_tab_right_with_tmux_terminal kak -c %val{session} -e "%arg{@}"
}

define-command open_new_tab_left_with_tmux -params .. %{
  open_new_tab_left_with_tmux_terminal kak -c %val{session} -e "%arg{@}"
}

define-command focus_client_with_tmux -params 1 %{
  evaluate-commands -client %arg{1} %{
    tmux switch-client -t %val{client_env_TMUX_PANE}
  }
}

define-command open_prompt_focus_client_with_tmux %{
  prompt -menu client_picker: -shell-script-candidates %opt{client_completion} %{
    focus_client_with_tmux %val{text}
  }
}

define-command yank_text_to_terminal_clipboard_with_tmux -params 1 %{
  tmux set-buffer -w %arg{1}
}

define-command yank_selected_text_to_terminal_clipboard_with_tmux %{
  yank_text_to_terminal_clipboard_with_tmux %val{selection}
}

define-command send_text_to_tmux_pane -params 2 %{
  tmux set-buffer %arg{1} ';' paste-buffer -p -t %arg{2}
}

define-command send_selected_text_to_tmux_pane -params 1 %{
  send_text_to_tmux_pane %val{selection} %arg{1}
}

define-command send_selected_lines_to_tmux_pane -params 1 %{
  evaluate-commands -draft %{
    execute-keys 'x'
    send_selected_text_to_tmux_pane %arg{1}
  }
}

define-command send_current_buffer_to_tmux_pane -params 1 %{
  evaluate-commands -draft %{
    execute-keys '%'
    send_selected_text_to_tmux_pane %arg{1}
  }
}

complete-command split_view_down_with_tmux command
complete-command split_view_right_with_tmux command
complete-command split_view_up_with_tmux command
complete-command split_view_left_with_tmux command
complete-command open_new_tab_with_tmux command
complete-command open_new_tab_right_with_tmux command
complete-command open_new_tab_left_with_tmux command

map -docstring 'split view down' global tmux s ':split_view_down_with_tmux<ret>'
map -docstring 'split view right' global tmux v ':split_view_right_with_tmux<ret>'
map -docstring 'split view up' global tmux S ':split_view_up_with_tmux<ret>'
map -docstring 'split view left' global tmux V ':split_view_left_with_tmux<ret>'
map -docstring 'open new tab right' global tmux w ':open_new_tab_right_with_tmux<ret>'
map -docstring 'open new tab left' global tmux W ':open_new_tab_left_with_tmux<ret>'
map -docstring 'focus client' global tmux f ':open_prompt_focus_client_with_tmux<ret>'
map -docstring 'yank selected text' global tmux y ':yank_selected_text_to_terminal_clipboard_with_tmux<ret>'
