# name: kakoune_find_buffers
# version: 0.1.0
# description: This script provides the functionality to find buffers.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
def find-buffers -params 1 %{
  edit -scratch "*find*"
  eval -save-regs """/" %{
    reg """" %val{buflist}
    reg / %arg{1}
    exec "ge<a-P>i<ret><esc>"
    try %{
      exec "<a-K><ret>xd"
    }
    exec "gg"
    try %{
      exec "<a-k>\n<ret>d"
    }
  }
}

compl find-buffers buffer
