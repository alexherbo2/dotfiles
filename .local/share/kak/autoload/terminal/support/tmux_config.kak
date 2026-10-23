# tmux
hook global User 'TERM_PROGRAM=tmux' %{
  set global terminal_command 'sh'
  set global terminal_args '-c' %{
    TMUX="$kak_client_env_TMUX" TMUX_PANE="$kak_client_env_TMUX_PANE" exec 'tmux' 'new-pane' '-O' '-K' '-x' '90%' '-y' '90%' '-c' "$PWD" '-e' 'TMUX=' '-e' 'TMUX_PANE=' 'tmux' 'new-session' '-A' '-s' "$kak_session" '--' "$@"
  } '--'
  set global terminal_tty %sh{
    TMUX="$kak_client_env_TMUX" TMUX_PANE="$kak_client_env_TMUX_PANE" exec tmux display-message -p '#{client_tty}'
  }
}
