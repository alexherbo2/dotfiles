# Zellij
hook global WinCreate ".*" %{
  hook -always -once window WinDisplay ".*" %{
    trigger-user-hook "ZELLIJ=%val{client_env_ZELLIJ}"
  }
}

hook global User 'ZELLIJ=0' %{
  set window terminal_command 'sh'
  set window terminal_args '-c' %{
    ZELLIJ_SESSION_NAME="$kak_client_env_ZELLIJ_SESSION_NAME" ZELLIJ_PANE_ID="$kak_client_env_ZELLIJ_PANE_ID" exec 'zellij' 'run' '-f' '--width=90%' '--height=90%' '--cwd=.' '-c' '--' "$@"
  } '--'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
