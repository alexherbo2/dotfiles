# foot
# https://codeberg.org/dnkl/foot
hook global User 'TERM=foot' %{
  set global terminal_command 'footclient'
  set global terminal_args '-D' '.' '--'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
