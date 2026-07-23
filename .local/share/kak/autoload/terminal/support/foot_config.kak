# foot
# https://codeberg.org/dnkl/foot
hook global User 'TERM=foot' %{
  set window terminal_command 'footclient'
  set window terminal_args '-D' '.' '--'
  set window terminal_tty '/dev/tty'
}
