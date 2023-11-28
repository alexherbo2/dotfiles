# Alacritty
# https://alacritty.org
# https://github.com/alacritty/alacritty
hook global User 'TERM=alacritty' %{
  set-option global tools_command alacritty
  set-option global tools_args msg create-window -e
}
