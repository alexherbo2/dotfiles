# Alacritty
# https://alacritty.org
# https://github.com/alacritty/alacritty
hook global User 'TERM=alacritty' %{
  set global terminal_command 'alacritty'
  set global terminal_args 'msg' '-s' "%val{client_env_ALACRITTY_SOCKET}" 'create-window' '-e'
  set global terminal_tty '/dev/tty'
}
