hook -group terminal-detection global ClientCreate '.*' %{
  trigger-user-hook "TERM=%val{client_env_TERM}"
}

hook global User 'TERM=alacritty' %{
  alias global open_new_client alacritty_open_new_client
  set-option global terminal_command alacritty
  set-option global terminal_args msg create-window -e
}

define-command alacritty_open_new_client -params .. %{
  nop %sh{
    alacritty msg create-window -e kak -c "$kak_session" -e "$*"
  }
}
complete-command alacritty_open_new_client command
