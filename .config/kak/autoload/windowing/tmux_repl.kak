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

define-command open_new_tmux_repl -params .. %{
  nop %sh{
    tmux split-window -d -h -P -F "set_tmux_repl '#D'" -- "$@" |
    kak -p "$kak_session"
  }
}

define-command open_new_tmux_repl_prompt %{
  prompt open_repl: -shell-completion %{
    open_new_tmux_repl sh -c %val{text}
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

complete-command open_new_tmux_repl shell

map -docstring 'new REPL' global tmux_repl n ':open_new_tmux_repl_prompt<ret>'
map -docstring 'choose REPL' global tmux_repl r ':choose_tmux_repl<ret>'
map -docstring 'send selected text to REPL with macro recording' global tmux_repl <ret> 'Q:send_selected_text_to_tmux_repl<ret>Q'
map -docstring 'send selected lines to REPL with macro recording' global tmux_repl 'x' 'Q:send_selected_lines_to_tmux_repl<ret>Q'
map -docstring 'send current buffer to REPL with macro recording' global tmux_repl '%' 'Q:send_current_buffer_to_tmux_repl<ret>Q'
