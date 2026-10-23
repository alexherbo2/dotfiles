# Console
hook global User 'TERM_PROGRAM=kgx' %{
  set global terminal_command 'kgx'
  set global terminal_args '--working-directory=.' '--'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
