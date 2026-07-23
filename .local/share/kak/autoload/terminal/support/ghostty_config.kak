# Ghostty
hook global User 'TERM=xterm-ghostty' %{
  set window terminal_command 'ghostty'
  set window terminal_args "--working-directory=." '+new-window' '-e'
  set window terminal_tty '/dev/tty'
}
