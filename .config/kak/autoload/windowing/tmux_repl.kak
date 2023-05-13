declare-option str tmux_repl_id
declare-user-mode tmux_repl

define-command enter_tmux_repl_mode %{
  enter-user-mode tmux_repl
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

#map -docstring 'REPL' global tmux <c-v> ':enter_tmux_repl_mode<ret>'
map -docstring 'choose REPL from window' global tmux_repl r ':choose_tmux_repl_from_window<ret>'
map -docstring 'choose REPL from tree' global tmux_repl R ':choose_tmux_repl_from_tree<ret>'
map -docstring 'send selected text to REPL with macro recording' global tmux_repl <ret> 'Q:send_selected_text_to_tmux_repl<ret>Q'
map -docstring 'send selected lines to REPL with macro recording' global tmux_repl 'x' 'Q:send_selected_lines_to_tmux_repl<ret>Q'
map -docstring 'send current buffer to REPL with macro recording' global tmux_repl '%' 'Q:send_current_buffer_to_tmux_repl<ret>Q'
