hook global User 'TERM=xterm-256color' %{
  set window terminal_command 'mate-terminal'
  set window terminal_args 'mate-terminal' '--window' '--'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
