# foot
# https://codeberg.org/dnkl/foot
hook global User 'TERM=foot' %{
  set-option global tools_command footclient
  set-option global tools_args
}
