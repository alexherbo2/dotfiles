# Xfce4 Terminal
hook global User 'TERM=xterm-256color' %{
  set window terminal_command 'xfce4-terminal'
  set window terminal_args '--window' '-x'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
