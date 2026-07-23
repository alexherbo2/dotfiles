# WezTerm
hook global User 'TERM_PROGRAM=WezTerm' %{
  set window terminal_command 'env'
  set window terminal_args "WEZTERM_UNIX_SOCKET=%val{client_env_WEZTERM_UNIX_SOCKET}" "WEZTERM_PANE=%val{client_env_WEZTERM_PANE}" 'wezterm' 'cli' 'spawn' '--new-window' "--cwd=%val{client_env_PWD}" '--'
  set window terminal_tty '/dev/tty'
}
