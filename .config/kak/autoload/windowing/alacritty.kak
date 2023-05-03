hook global ClientCreate '.*' %{
  trigger-user-hook "TERM=%val{client_env_TERM}"
}

hook global User 'TERM=alacritty' %{
  set-option global terminal_command alacritty
  set-option global terminal_args msg create-window -e
}
