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

define-command split_view_down_with_tmux -params .. %{
  tmux split-window -v kak -c %val{session} -e "%arg{@}"
}

define-command split_view_right_with_tmux -params .. %{
  tmux split-window -h kak -c %val{session} -e "%arg{@}"
}

define-command create_view_in_new_window_with_tmux -params .. %{
  tmux new-window -a kak -c %val{session} -e "%arg{@}"
}

define-command move_view_to_new_window_with_tmux %{
  tmux break-pane -a
}

define-command close_view_with_tmux %{
  tmux kill-pane
}

define-command close_other_viewports_with_tmux %{
  tmux kill-pane -a
}

define-command open_view_in_popup_with_tmux -params .. %{
  tmux display-popup -w 90% -h 90% -E kak -c %val{session} -e "%arg{@}"
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

define-command choose_view_with_tmux %{
  tmux choose-tree -Zw
}

define-command move_view_to_window_with_tmux_menu %{
  tmux choose-tree -Zw %{
    join-pane -t '%%'
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
complete-command create_view_in_new_window_with_tmux command
complete-command open_view_in_popup_with_tmux command

map -docstring 'jump_view_left_with_tmux' global tmux h ':jump_view_left_with_tmux<ret>'
map -docstring 'jump_view_down_with_tmux' global tmux j ':jump_view_down_with_tmux<ret>'
map -docstring 'jump_view_up_with_tmux' global tmux k ':jump_view_up_with_tmux<ret>'
map -docstring 'jump_view_right_with_tmux' global tmux l ':jump_view_right_with_tmux<ret>'

map -docstring 'swap_view_left_with_tmux' global tmux H ':swap_view_left_with_tmux<ret>'
map -docstring 'swap_view_down_with_tmux' global tmux J ':swap_view_down_with_tmux<ret>'
map -docstring 'swap_view_up_with_tmux' global tmux K ':swap_view_up_with_tmux<ret>'
map -docstring 'swap_view_right_with_tmux' global tmux L ':swap_view_right_with_tmux<ret>'

map -docstring 'shrink_viewport_right_with_tmux' global tmux <c-h> ':shrink_viewport_right_with_tmux<ret>'
map -docstring 'grow_viewport_down_with_tmux' global tmux <c-j> ':grow_viewport_down_with_tmux<ret>'
map -docstring 'shrink_viewport_down_with_tmux' global tmux <c-k> ':shrink_viewport_down_with_tmux<ret>'
map -docstring 'grow_viewport_right_with_tmux' global tmux <c-l> ':grow_viewport_right_with_tmux<ret>'

map -docstring 'split_view_down_with_tmux' global tmux o ':split_view_down_with_tmux<ret>'
map -docstring 'split_view_right_with_tmux' global tmux O ':split_view_right_with_tmux<ret>'

map -docstring 'create_view_in_new_window_with_tmux' global tmux n ':create_view_in_new_window_with_tmux<ret>'
map -docstring 'move_view_to_new_window_with_tmux' global tmux T ':move_view_to_new_window_with_tmux<ret>'

map -docstring 'close_view_with_tmux' global tmux x ':close_view_with_tmux<ret>'
map -docstring 'close_other_viewports_with_tmux' global tmux X ':close_other_viewports_with_tmux<ret>'

map -docstring 'open_view_in_popup_with_tmux' global tmux + ':open_view_in_popup_with_tmux<ret>'

map -docstring 'open_prompt_focus_client_with_tmux' global tmux w ':open_prompt_focus_client_with_tmux<ret>'
map -docstring 'choose_view_with_tmux' global tmux s ':choose_view_with_tmux<ret>'
map -docstring 'move_view_to_window_with_tmux_menu' global tmux @ ':move_view_to_window_with_tmux_menu<ret>'

map -docstring 'yank_selected_text_to_terminal_clipboard_with_tmux' global tmux y ':yank_selected_text_to_terminal_clipboard_with_tmux<ret>'
map -docstring 'enter_tmux_repl_mode' global tmux r ':enter_tmux_repl_mode<ret>'
