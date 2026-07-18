# Kitty
hook global User 'TERM=xterm-kitty' %{
  set global terminal_command 'kitten'
  set global terminal_args '@' 'launch' '--type=os-window' '--'
  set global terminal_tty '/dev/tty'
}
