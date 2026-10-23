# Ghostty
hook global User 'GHOSTTY_PLATFORM=(DragonFly|FreeBSD|NetBSD)' %{
  set global terminal_command 'ghostty'
  set global terminal_args '+new-window' '--working-directory=.' '-e'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
