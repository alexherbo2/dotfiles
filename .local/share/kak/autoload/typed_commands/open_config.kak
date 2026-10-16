def -docstring "
usage: open-config
description: open config file.
config_options: []
" open-config %{
  edit -- "%val{config}/kakrc"
}
