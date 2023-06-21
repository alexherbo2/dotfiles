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
    TMUX=$kak_client_env_TMUX TMUX_PANE=$kak_client_env_TMUX_PANE nohup tmux set-environment kak_session "$kak_session" ';' set-environment kak_client "$kak_client" ';' "$@" < /dev/null > /dev/null 2>&1 &
  }
}

define-command tmux_focus_pane_left %{
  tmux select-pane -L
}

define-command tmux_focus_pane_down %{
  tmux select-pane -D
}

define-command tmux_focus_pane_up %{
  tmux select-pane -U
}

define-command tmux_focus_pane_right %{
  tmux select-pane -R
}

define-command tmux_move_pane_left %{
  tmux swap-pane -s '{left-of}'
}

define-command tmux_move_pane_down %{
  tmux swap-pane -s '{down-of}'
}

define-command tmux_move_pane_up %{
  tmux swap-pane -s '{up-of}'
}

define-command tmux_move_pane_right %{
  tmux swap-pane -s '{right-of}'
}

define-command tmux_resize_pane_left %{
  tmux resize-pane -L 5
}

define-command tmux_resize_pane_down %{
  tmux resize-pane -D 2
}

define-command tmux_resize_pane_up %{
  tmux resize-pane -U 2
}

define-command tmux_resize_pane_right %{
  tmux resize-pane -R 5
}

define-command tmux_open_new_pane_down -params .. %{
  tmux split-window -v kak -c %val{session} -e "%arg{@}"
}

define-command tmux_open_new_pane_right -params .. %{
  tmux split-window -h kak -c %val{session} -e "%arg{@}"
}

define-command tmux_open_new_window -params .. %{
  tmux new-window -a kak -c %val{session} -e "%arg{@}"
}

define-command open_new_popup_with_tmux -params .. %{
  tmux display-popup -w 90% -h 90% -E kak -c %val{session} -e "%arg{@}"
}

define-command tmux_close_pane %{
  tmux kill-pane
}

define-command tmux_close_other_panes %{
  tmux kill-pane -a
}

define-command tmux_focus_client -params 1 %{
  evaluate-commands -client %arg{1} %{
    tmux switch-client -t %val{client_env_TMUX_PANE}
  }
}

define-command tmux_open_prompt_focus_client %{
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

define-command tmux_move_pane_to_new_window %{
  tmux break-pane -a
}

define-command tmux_choose_window %{
  tmux choose-tree -Zw
}

define-command tmux_choose_move_pane_to_window %{
  tmux choose-tree -Zw %{
    join-pane -s '%%'
  }
}

# complete-command split_view_down_with_tmux command
# complete-command split_view_right_with_tmux command
# complete-command split_view_up_with_tmux command
# complete-command split_view_left_with_tmux command
# complete-command open_new_tab_with_tmux command
# complete-command open_new_tab_right_with_tmux command
# complete-command open_new_tab_left_with_tmux command
# complete-command open_new_popup_with_tmux command

map -docstring 'focus pane left' global tmux h ':tmux_focus_pane_left<ret>'
map -docstring 'focus pane down' global tmux j ':tmux_focus_pane_down<ret>'
map -docstring 'focus pane up' global tmux k ':tmux_focus_pane_up<ret>'
map -docstring 'focus pane right' global tmux l ':tmux_focus_pane_right<ret>'

map -docstring 'move pane left' global tmux H ':tmux_move_pane_left<ret>'
map -docstring 'move pane down' global tmux J ':tmux_move_pane_down<ret>'
map -docstring 'move pane up' global tmux K ':tmux_move_pane_up<ret>'
map -docstring 'move pane right' global tmux L ':tmux_move_pane_right<ret>'

map -docstring 'resize pane left' global tmux <c-h> ':tmux_resize_pane_left<ret>'
map -docstring 'resize pane down' global tmux <c-j> ':tmux_resize_pane_down<ret>'
map -docstring 'resize pane up' global tmux <c-k> ':tmux_resize_pane_up<ret>'
map -docstring 'resize pane right' global tmux <c-l> ':tmux_resize_pane_right<ret>'

map -docstring 'open new pane down' global tmux o ':tmux_open_new_pane_down<ret>'
map -docstring 'open new pane right' global tmux O ':tmux_open_new_pane_right<ret>'

map -docstring 'open new window' global tmux n ':tmux_open_new_window<ret>'
map -docstring 'move pane to new window' global tmux T ':tmux_move_pane_to_new_window<ret>'

map -docstring 'close current viewport' global tmux x ':tmux_close_pane<ret>'
map -docstring 'close other viewports' global tmux X ':tmux_close_other_panes<ret>'

map -docstring 'move pane to window' global tmux @ ':tmux_choose_move_pane_to_window<ret>'
map -docstring 'open new popup with tmux' global tmux + ':open_new_popup_with_tmux<ret>'
map -docstring 'focus client' global tmux w ':tmux_open_prompt_focus_client<ret>'
map -docstring 'choose window' global tmux s ':tmux_choose_window<ret>'
map -docstring 'yank selected text' global tmux y ':yank_selected_text_to_terminal_clipboard_with_tmux<ret>'
map -docstring 'repl' global tmux r ':enter_tmux_repl_mode<ret>'
