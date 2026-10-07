def -docstring "
usage: new-scratchpad
description: open scratchpad in a new scratch buffer.
config_files: [""%val{runtime}/scratch.txt"", ""%val{config}/scratch.txt""]
aliases: [""s""]
" new-scratchpad %{
  fifo -name "*scratch*" sh -c %{
    if [ -r "$kak_config/scratch.txt" ]
    then
      cat -- "$kak_config/scratch.txt"
    else
      cat -- "$kak_runtime/scratch.txt"
    fi
  }
}
alias global s new-scratchpad
