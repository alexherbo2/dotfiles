# WezTerm
hook global User 'TERM_PROGRAM=WezTerm' %{
  set global terminal_command 'env'
  set global terminal_args "WEZTERM_UNIX_SOCKET=%val{client_env_WEZTERM_UNIX_SOCKET}" "WEZTERM_PANE=%val{client_env_WEZTERM_PANE}" 'wezterm' 'cli' 'spawn' '--new-window' "--cwd=%val{client_env_PWD}" '--'
  set global terminal_tty '/dev/tty'
}
