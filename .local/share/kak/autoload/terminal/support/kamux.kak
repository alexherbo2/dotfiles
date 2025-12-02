hook global User 'TERM_PROGRAM=kamux' %{
  set global terminal_command env
  set global terminal_args "TMUX=%val{client_env_TMUX}" "TMUX_PANE=%val{client_env_TMUX_PANE}" tmux display-popup -w '90%' -h '90%' -d '#{pane_current_path}' -E kamux-terminal -s %val{session} --
  set global terminal_tty %sh{
    tmux display-message -p '#{client_tty}'
  }
}
