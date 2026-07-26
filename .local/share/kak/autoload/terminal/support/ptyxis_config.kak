# Ptyxis
hook global User 'TERM=xterm-256color' %{
  set window terminal_command 'ptyxis'
  set window terminal_args '--new-window' "--tab-with-profile=%val{client_env_PTYXIS_PROFILE}" '-d' '.' '--'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
