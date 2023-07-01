declare-option str tmux_repl_id

declare-user-mode tmux_repl

define-command enter_tmux_repl_mode %{
  enter-user-mode tmux_repl
}

define-command set_tmux_repl -params 1 %{
  set-option global tmux_repl_id %arg{1}
}

define-command choose_tmux_repl %{
  tmux display-panes -d 0 %{
    run-shell '
      echo set_tmux_repl "\\%%" | kak -p "$kak_session"
    '
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

map -docstring 'choose REPL' global tmux_repl r ':choose_tmux_repl<ret>'
map -docstring 'send selected text to REPL with macro recording' global tmux_repl <ret> 'Q:send_selected_text_to_tmux_repl<ret>Q'
map -docstring 'send selected lines to REPL with macro recording' global tmux_repl 'x' 'Q:send_selected_lines_to_tmux_repl<ret>Q'
map -docstring 'send current buffer to REPL with macro recording' global tmux_repl '%' 'Q:send_current_buffer_to_tmux_repl<ret>Q'
