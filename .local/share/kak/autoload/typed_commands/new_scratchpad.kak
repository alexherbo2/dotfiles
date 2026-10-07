def -docstring "
usage: new-scratchpad
description: open scratchpad in a new scratch buffer.
config_files: [""%val{runtime}/scratchpad.txt"", ""%val{config}/scratchpad.txt""]
aliases: [""s""]
" new-scratchpad %{
  fifo -name "*scratchpad*" sh -c %{
    if [ -r "$kak_config/scratchpad.txt" ]
    then
      cat -- "$kak_config/scratchpad.txt"
    else
      cat -- "$kak_runtime/scratchpad.txt"
    fi
  }
}
alias global s new-scratchpad
