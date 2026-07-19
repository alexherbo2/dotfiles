# Kitty
hook global User 'TERM=xterm-kitty' %{
  set global terminal_command 'kitten'
  set global terminal_args '@' "--to=%val{client_env_KITTY_LISTEN_ON}" 'launch' "--match=window_id:%val{client_env_KITTY_WINDOW_ID}" '--type=os-window' "--cwd=%val{client_env_PWD}" '--'
  set global terminal_tty '/dev/tty'
}
