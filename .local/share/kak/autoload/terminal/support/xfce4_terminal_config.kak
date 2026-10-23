# Xfce4 Terminal
hook global User 'KAKOUNE_TERM_PROGRAM=xfce4-terminal' %{
  set global terminal_command 'xfce4-terminal'
  set global terminal_args '--window' '-x'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
