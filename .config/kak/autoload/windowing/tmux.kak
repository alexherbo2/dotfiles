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

define-command focus_window_left_with_tmux %{
  tmux select-pane -L
}

define-command focus_window_below_with_tmux %{
  tmux select-pane -D
}

define-command focus_window_above_with_tmux %{
  tmux select-pane -U
}

define-command focus_window_right_with_tmux %{
  tmux select-pane -R
}

define-command move_window_left_with_tmux %{
  tmux swap-pane -s '{left-of}'
}

define-command move_window_below_with_tmux %{
  tmux swap-pane -s '{down-of}'
}

define-command move_window_above_with_tmux %{
  tmux swap-pane -s '{up-of}'
}

define-command move_window_right_with_tmux %{
  tmux swap-pane -s '{right-of}'
}

define-command move_window_to_new_tab_with_tmux %{
  tmux break-pane -a
}

define-command resize_window_left_with_tmux %{
  tmux resize-pane -L 5
}

define-command resize_window_down_with_tmux %{
  tmux resize-pane -D 2
}

define-command resize_window_up_with_tmux %{
  tmux resize-pane -U 2
}

define-command resize_window_right_with_tmux %{
  tmux resize-pane -R 5
}

define-command split_view_down_with_tmux -params .. %{
  tmux split-window -v kak -c %val{session} -e "%arg{@}"
}

define-command split_view_right_with_tmux -params .. %{
  tmux split-window -h kak -c %val{session} -e "%arg{@}"
}

define-command split_view_up_with_tmux -params .. %{
  tmux split-window -v -b kak -c %val{session} -e "%arg{@}"
}

define-command split_view_left_with_tmux -params .. %{
  tmux split-window -h -b kak -c %val{session} -e "%arg{@}"
}

define-command open_new_tab_with_tmux -params .. %{
  tmux new-window kak -c %val{session} -e "%arg{@}"
}

define-command open_new_tab_right_with_tmux -params .. %{
  tmux new-window -a kak -c %val{session} -e "%arg{@}"
}

define-command open_new_tab_left_with_tmux -params .. %{
  tmux new-window -b kak -c %val{session} -e "%arg{@}"
}

define-command open_new_popup_with_tmux -params .. %{
  tmux display-popup -w 90% -h 90% -E kak -c %val{session} -e "%arg{@}"
}

define-command close_current_viewport_with_tmux %{
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

define-command choose_tmux_window %{
  tmux choose-tree -Zw
}

complete-command split_view_down_with_tmux command
complete-command split_view_right_with_tmux command
complete-command split_view_up_with_tmux command
complete-command split_view_left_with_tmux command
complete-command open_new_tab_with_tmux command
complete-command open_new_tab_right_with_tmux command
complete-command open_new_tab_left_with_tmux command
complete-command open_new_popup_with_tmux command

map -docstring 'focus window left' global tmux h ':focus_window_left_with_tmux<ret>'
map -docstring 'focus window below' global tmux j ':focus_window_below_with_tmux<ret>'
map -docstring 'focus window above' global tmux k ':focus_window_above_with_tmux<ret>'
map -docstring 'focus window right' global tmux l ':focus_window_right_with_tmux<ret>'

map -docstring 'move window left' global tmux H ':move_window_left_with_tmux<ret>'
map -docstring 'move window below' global tmux J ':move_window_below_with_tmux<ret>'
map -docstring 'move window above' global tmux K ':move_window_above_with_tmux<ret>'
map -docstring 'move window right' global tmux L ':move_window_right_with_tmux<ret>'

map -docstring 'move window to new tab' global tmux T ':move_window_to_new_tab_with_tmux<ret>'

map -docstring 'resize window left' global tmux <c-h> ':resize_window_left_with_tmux<ret>'
map -docstring 'resize window down' global tmux <c-j> ':resize_window_down_with_tmux<ret>'
map -docstring 'resize window up' global tmux <c-k> ':resize_window_up_with_tmux<ret>'
map -docstring 'resize window right' global tmux <c-l> ':resize_window_right_with_tmux<ret>'

map -docstring 'split view down' global tmux o ':split_view_down_with_tmux<ret>'
map -docstring 'split view right' global tmux O ':split_view_right_with_tmux<ret>'
map -docstring 'split view up' global tmux <a-o> ':split_view_up_with_tmux<ret>'
map -docstring 'split view left' global tmux <a-O> ':split_view_left_with_tmux<ret>'
map -docstring 'open new tab' global tmux n ':open_new_tab_right_with_tmux<ret>'

map -docstring 'close current viewport' global tmux x ':close_current_viewport_with_tmux<ret>'
map -docstring 'close other viewports' global tmux X ':close_other_viewports_with_tmux<ret>'

map -docstring 'open new popup with tmux' global tmux + ':open_new_popup_with_tmux<ret>'
map -docstring 'focus client' global tmux w ':open_prompt_focus_client_with_tmux<ret>'
map -docstring 'choose window' global tmux W ':choose_tmux_window<ret>'
map -docstring 'yank selected text' global tmux y ':yank_selected_text_to_terminal_clipboard_with_tmux<ret>'
map -docstring 'repl' global tmux r ':enter_tmux_repl_mode<ret>'
