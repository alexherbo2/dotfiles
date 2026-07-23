# foot
# https://codeberg.org/dnkl/foot
hook global User 'TERM=foot' %{
  set window terminal_command 'footclient'
  set window terminal_args '-D' '.' '--'
  set window terminal_tty %sh{
    printf '/dev/'
    ps -o 'tty=' -p "$kak_client_pid" |
    awk '
      {
        print $1
      }
    '
  }
}
