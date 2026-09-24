# Ghostty
hook global User 'GHOSTTY_PLATFORM=(DragonFly|FreeBSD|NetBSD)' %{
  set window terminal_command 'ghostty'
  set window terminal_args '+new-window' '--working-directory=.' '-e'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
