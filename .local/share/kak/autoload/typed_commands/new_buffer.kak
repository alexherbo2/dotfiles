def -docstring '
usage: new-buffer
description: create a new scratch buffer.
config_options: []
aliases: ["n"]
' new-buffer %{
  edit -scratch '*scratch*'
}

alias global n new-buffer
