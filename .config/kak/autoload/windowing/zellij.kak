# https://zellij.dev
hook global ClientCreate '.*' %{
  trigger-user-hook "ZELLIJ=%val{client_env_ZELLIJ}"
}

hook global User 'ZELLIJ=.+' %{
  set-option global terminal_command zellij
  set-option global terminal_args run --direction=right --
}
