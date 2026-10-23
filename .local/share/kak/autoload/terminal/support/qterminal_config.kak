# QTerminal
hook global User 'KAKOUNE_TERM_PROGRAM=qterminal' %{
  set global terminal_command 'qterminal'
  set global terminal_args '-w' '.' '-e'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
