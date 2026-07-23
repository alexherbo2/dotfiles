# Ghostty
hook global User 'TERM=xterm-ghostty' %{
  set window terminal_command 'ghostty'
  set window terminal_args "--working-directory=." '+new-window' '-e'
  set window terminal_tty %sh{
    printf '/dev/'
    ps -o 'tty=' -p "$kak_client_pid" |
    awk '
      {
        print $1
      }
    '
  }
}
