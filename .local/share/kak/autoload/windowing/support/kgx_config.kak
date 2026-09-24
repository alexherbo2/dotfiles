# Console
hook global User 'TERM_PROGRAM=kgx' %{
  set window terminal_command 'kgx'
  set window terminal_args '--working-directory=.' '--'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
