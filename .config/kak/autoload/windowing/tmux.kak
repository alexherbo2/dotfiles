# https://github.com/tmux/tmux
declare-user-mode tmux
declare-user-mode tmux_repl
declare-option str tmux_repl_id

hook global ClientCreate '.*' %{
  trigger-user-hook "TMUX=%val{client_env_TMUX}"
}

hook global User 'TMUX=.+' %{
  set-option global terminal_command tmux
  set-option global terminal_args split-window -h
  map -docstring 'enter tmux mode' global user w ':enter_tmux_mode<ret>'
}

define-command enter_tmux_mode %{
  enter-user-mode tmux
}

define-command enter_tmux_repl_mode %{
  enter-user-mode tmux_repl
}

define-command tmux -params 1.. %{
  nop %sh{
    TMUX=$kak_client_env_TMUX \
    TMUX_PANE=$kak_client_env_TMUX_PANE \
    tmux \
    set-environment kak_session "$kak_session" \;\
    set-environment kak_client "$kak_client" \;\
    "$@"
  }
}

define-command split_view_right_with_tmux %{
  tmux split-window -h kak -c %val{session}
}

define-command split_view_left_with_tmux %{
  tmux split-window -h -b kak -c %val{session}
}

define-command split_view_down_with_tmux %{
  tmux split-window -v kak -c %val{session}
}

define-command split_view_up_with_tmux %{
  tmux split-window -v -b kak -c %val{session}
}

define-command open_new_terminal_client_with_tmux %{
  tmux new-window -a %arg{@}
}

define-command focus_client_with_tmux -params 1 %{
  evaluate-commands -client %arg{1} %{
    tmux switch-client -t %val{client_env_TMUX_PANE}
  }
}

define-command open_client_picker_with_tmux %{
  prompt -menu client_picker: -client-completion %{
    focus_client_with_tmux %val{text}
  }
}

define-command yank_selected_text_to_terminal_clipboard_with_tmux %{
  tmux set-buffer -w %val{main_reg_dquote}
}

define-command set_tmux_repl -params 1 %{
  set-option global tmux_repl_id %arg{1}
}

define-command choose_tmux_repl_from_window -params .. %{
  tmux display-panes -d 0 %{
    run-shell '
      echo set_tmux_repl '\%%' | kak -p "$kak_session"
    '
  }
}

define-command choose_tmux_repl_from_tree -params .. %{
  tmux choose-tree -Zw %{
    run-shell '
      echo set_tmux_repl '%%' | kak -p "$kak_session"
    '
  }
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

define-command send_selected_text_to_tmux_repl %{
  send_selected_text_to_tmux_pane %opt{tmux_repl_id}
}

define-command send_selected_lines_to_tmux_repl %{
  send_selected_lines_to_tmux_pane %opt{tmux_repl_id}
}

define-command send_current_buffer_to_tmux_repl %{
  send_current_buffer_to_tmux_pane %opt{tmux_repl_id}
}

map -docstring 'split view left' global tmux h ':split_view_left_with_tmux<ret>'
map -docstring 'split view down' global tmux j ':split_view_down_with_tmux<ret>'
map -docstring 'split view up' global tmux k ':split_view_up_with_tmux<ret>'
map -docstring 'split view right' global tmux l ':split_view_right_with_tmux<ret>'

map -docstring 'REPL' global tmux <c-v> ':enter_tmux_repl_mode<ret>'
map -docstring 'choose REPL from window' global tmux_repl r ':choose_tmux_repl_from_window<ret>'
map -docstring 'choose REPL from tree' global tmux_repl R ':choose_tmux_repl_from_tree<ret>'
map -docstring 'send selected text to REPL with macro recording' global tmux_repl <ret> 'Q:send_selected_text_to_tmux_repl<ret>Q'
map -docstring 'send selected lines to REPL with macro recording' global tmux_repl 'x' 'Q:send_selected_lines_to_tmux_repl<ret>Q'
map -docstring 'send current buffer to REPL with macro recording' global tmux_repl '%' 'Q:send_current_buffer_to_tmux_repl<ret>Q'
