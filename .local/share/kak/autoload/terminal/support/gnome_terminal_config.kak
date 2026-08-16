# Gnome Terminal
hook global WinCreate ".*" %{
  hook -always -once window WinDisplay ".*" %{
    trigger-user-hook "GNOME_TERMINAL_SERVICE=%val{client_env_GNOME_TERMINAL_SERVICE}"
  }
}

hook global User 'GNOME_TERMINAL_SERVICE=.+' %{
  set window terminal_command 'env'
  set window terminal_args "GNOME_TERMINAL_SERVICE=%val{client_env_GNOME_TERMINAL_SERVICE}" "GNOME_TERMINAL_SCREEN=%val{client_env_GNOME_TERMINAL_SCREEN}" 'gnome-terminal' '--window' '--'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
