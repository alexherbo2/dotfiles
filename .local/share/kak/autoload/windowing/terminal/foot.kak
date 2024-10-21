# foot
# https://codeberg.org/dnkl/foot
hook global User 'TERM=foot' %{
  set-option global terminal_command footclient
  set-option global terminal_args
}
