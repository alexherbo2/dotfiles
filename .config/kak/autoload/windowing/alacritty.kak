# Alacritty
# https://alacritty.org
# https://github.com/alacritty/alacritty
hook global ClientCreate '.*' %{
  trigger-user-hook "ALACRITTY_SOCKET=%val{client_env_ALACRITTY_SOCKET}"
}

hook global User 'ALACRITTY_SOCKET=.+' %{
  set-option global terminal_command alacritty
  set-option global terminal_args msg create-window -e
}
