# Konsole
hook global User 'TERM=xterm-256color' %{
  set window terminal_command 'konsole'
  set window terminal_args "--workdir=." '-e'
  set window terminal_tty '/dev/tty'
}
