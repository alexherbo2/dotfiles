hook global User 'KAKOUNE_TERM_PROGRAM=mate-terminal' %{
  set global terminal_command 'mate-terminal'
  set global terminal_args '--window' '--'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
