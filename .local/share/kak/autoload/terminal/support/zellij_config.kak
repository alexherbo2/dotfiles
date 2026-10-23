# Zellij
hook global ClientCreate ".*" %{
  trigger-user-hook "ZELLIJ=%val{client_env_ZELLIJ}"
}

hook global User 'ZELLIJ=0' %{
  set global terminal_command 'sh'
  set global terminal_args '-c' %{
    ZELLIJ_SESSION_NAME="$kak_client_env_ZELLIJ_SESSION_NAME" ZELLIJ_PANE_ID="$kak_client_env_ZELLIJ_PANE_ID" exec 'zellij' 'run' '-f' '--width=90%' '--height=90%' '--cwd=.' '-c' '--' "$@"
  } '--'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
