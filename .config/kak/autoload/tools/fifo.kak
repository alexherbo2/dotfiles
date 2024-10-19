# name: kakoune_fifo
# version: 0.1.0
# description: This script provides the functionality to create buffers from command outputs.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
define-command fifo -params 1.. %{
  evaluate-commands %sh{
    fifo=$(mktemp -u)
    mkfifo "$fifo"
    { "$@" > "$fifo" 2>&1; } < /dev/null > /dev/null 2>&1 &
    cat <<EOF
      edit! -fifo "$fifo" -- "$fifo"
      hook -always -once buffer BufCloseFifo "" %{
        nop %sh{
          unlink "$fifo"
        }
      }
EOF
  }
}

complete-command fifo shell

alias global ! fifo
