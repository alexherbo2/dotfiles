hook global User 'TERM_PLATFORM=(DragonFly|FreeBSD|NetBSD)' %{
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
