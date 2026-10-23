# WezTerm
hook global User 'TERM_PROGRAM=WezTerm' %{
  set global terminal_command 'env'
  set global terminal_args "WEZTERM_UNIX_SOCKET=%val{client_env_WEZTERM_UNIX_SOCKET}" "WEZTERM_PANE=%val{client_env_WEZTERM_PANE}" 'wezterm' 'cli' 'spawn' '--new-window' '--cwd=.' '--'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
