# https://sw.kovidgoyal.net/kitty/
hook global ClientCreate '.*' %{
  trigger-user-hook "TERM=%val{client_env_TERM}"
}

hook global User 'TERM=xterm-kitty' %{
  set-option global terminal_command kitty
  set-option global terminal_args @ launch
}
