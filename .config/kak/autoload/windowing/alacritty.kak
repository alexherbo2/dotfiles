# Alacritty
# https://alacritty.org
# https://github.com/alacritty/alacritty
hook global User 'TERM=alacritty' %{
  set-option global terminal_command alacritty
  set-option global terminal_args msg create-window -e
}
