def -docstring '
usage: new-buffer [buffer_name]
description: create a new scratch buffer.
config_options: []
aliases: ["n"]
' new-buffer -params 0..1 %{
  edit! -scratch -- %arg{@}
}

alias global n new-buffer
