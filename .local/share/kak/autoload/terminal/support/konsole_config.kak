# Konsole
hook global User 'TERM=xterm-konsole' %{
  set global terminal_command 'konsole'
  set global terminal_args "--workdir=." '-e'
  set global terminal_tty '/dev/tty'
}
