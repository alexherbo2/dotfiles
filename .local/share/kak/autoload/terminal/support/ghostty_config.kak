# Ghostty
hook global User 'TERM=xterm-ghostty' %{
  set global terminal_command 'ghostty'
  set global terminal_args "--working-directory=." '+new-window' '-e'
  set global terminal_tty '/dev/tty'
}
