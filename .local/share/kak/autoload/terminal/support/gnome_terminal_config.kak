# Gnome Terminal
hook global ClientCreate ".*" %{
  trigger-user-hook "GNOME_TERMINAL_SERVICE=%val{client_env_GNOME_TERMINAL_SERVICE}"
}

hook global User 'GNOME_TERMINAL_SERVICE=.+' %{
  set global terminal_command 'env'
  set global terminal_args "GNOME_TERMINAL_SERVICE=%val{client_env_GNOME_TERMINAL_SERVICE}" "GNOME_TERMINAL_SCREEN=%val{client_env_GNOME_TERMINAL_SCREEN}" 'gnome-terminal' '--window' '--'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
