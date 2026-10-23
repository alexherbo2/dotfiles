hook global User 'TERM_PLATFORM=(DragonFly|FreeBSD|NetBSD)' %{
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
