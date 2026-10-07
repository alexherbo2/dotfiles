def -docstring "
usage: intro
description: show introduction.
config_options: []
" intro %{
  edit -readonly -- "%val{runtime}/doc/intro.md"
}
