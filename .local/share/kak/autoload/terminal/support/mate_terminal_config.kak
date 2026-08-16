hook global User 'KAKOUNE_TERM_PROGRAM=mate-terminal' %{
  set window terminal_command 'mate-terminal'
  set window terminal_args '--window' '--'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
