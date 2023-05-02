hook -group terminal-detection global ClientCreate '.*' %{
  trigger-user-hook "TERM=%val{client_env_TERM}"
}

hook global User 'TERM=foot' %{
  alias global open_new_client foot_open_new_client
  set-option global terminal_command footclient
  set-option global terminal_args -e
}

define-command foot_open_new_client -params .. %{
  nop %sh{
    footclient -e kak -c "$kak_session" -e "$*"
  }
}
complete-command foot_open_new_client command
