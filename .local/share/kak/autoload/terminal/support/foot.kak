# foot
# https://codeberg.org/dnkl/foot
hook global User 'TERM=foot' %{
  set global terminal_command footclient
  set global terminal_args
  set global terminal_tty '/dev/tty'
}
