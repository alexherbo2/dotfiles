# Alacritty
# https://alacritty.org
# https://github.com/alacritty/alacritty
# https://github.com/alacritty/alacritty/blob/master/alacritty.yml

hook global ClientCreate .* %{
  trigger-user-hook "ALACRITTY_SOCKET=%val{client_env_ALACRITTY_SOCKET}"
  trigger-user-hook "ALACRITTY_LOG=%val{client_env_ALACRITTY_LOG}"
  trigger-user-hook "ALACRITTY_WINDOW_ID=%val{client_env_ALACRITTY_WINDOW_ID}"
}

define-command alacritty -params 1.. %{
  nop %sh{
    ALACRITTY_SOCKET=$kak_client_env_ALACRITTY_SOCKET ALACRITTY_LOG=$kak_client_env_ALACRITTY_LOG ALACRITTY_WINDOW_ID=$kak_client_env_ALACRITTY_WINDOW_ID alacritty "$@"
  }
}

define-command open_new_window_with_alacritty -params .. %{
  alacritty msg create-window -e kak -c %val{session} -e "%arg{@}"
}

complete-command open_new_window_with_alacritty command
