declare-option str tmux_repl_id

define-command set_tmux_repl -params 1 %{
  set-option global tmux_repl_id %arg{1}
}

define-command choose_tmux_repl %{
  tmux choose-tree -Zsw -f '#{!=:kak,#{pane_current_command}}' %{
    run-shell '
      echo set_tmux_repl "%%" | kak -p "$kak_session"
    '
  }
}

define-command send_text_to_tmux_repl -params 1 %{
  send_text_to_tmux_pane %arg{1} %opt{tmux_repl_id}
}

define-command send_selected_text_to_tmux_repl %{
  send_selected_text_to_tmux_pane %opt{tmux_repl_id}
}

hook global KakBegin .* %{
map -docstring 'choose REPL' global tmux r ':choose_tmux_repl<ret>'
map -docstring 'send selected text to REPL' global tmux <ret> ':send_selected_text_to_tmux_repl<ret>'
}
