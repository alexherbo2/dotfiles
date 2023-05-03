hook global ClientCreate '.*' %{
  trigger-user-hook "TERM=%val{client_env_TERM}"
}

hook global User 'TERM=foot' %{
  set-option global terminal_command footclient
  set-option global terminal_args -e
}
