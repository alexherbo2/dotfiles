# QTerminal
hook global User 'KAKOUNE_TERM_PROGRAM=qterminal' %{
  set window terminal_command 'qterminal'
  set window terminal_args '-w' '.' '-e'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
