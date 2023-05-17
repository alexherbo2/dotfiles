# Alacritty
# https://alacritty.org
# https://github.com/alacritty/alacritty
# https://github.com/alacritty/alacritty/blob/master/alacritty.yml
define-command alacritty -params 1.. %{
  nop %sh{
    ALACRITTY_SOCKET=$kak_client_env_ALACRITTY_SOCKET ALACRITTY_LOG=$kak_client_env_ALACRITTY_LOG ALACRITTY_WINDOW_ID=$kak_client_env_ALACRITTY_WINDOW_ID alacritty "$@"
  }
}

define-command open_new_terminal_app_with_alacritty -params 1.. %{
  alacritty msg create-window -e %arg{@}
}

define-command open_new_terminal_client_with_alacritty -params .. %{
  open_new_terminal_app_with_alacritty kak -c %val{session} -e "%arg{@}"
}

complete-command open_new_terminal_app_with_alacritty shell
complete-command open_new_terminal_client_with_alacritty command
