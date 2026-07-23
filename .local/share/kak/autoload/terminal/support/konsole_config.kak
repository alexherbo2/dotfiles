# Konsole
hook global User 'TERM=xterm-256color' %{
  set window terminal_command 'konsole'
  set window terminal_args "--workdir=." '-e'
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
