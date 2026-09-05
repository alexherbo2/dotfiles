# name: kakoune_cat
# version: 0.1.0
# description: This script provides support for the cat command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def -docstring '
usage: cat [files]
description: concatenate and insert the content of files below selected text.
config_options: []
' cat -params 1.. %{
  eval -save-regs "a" %{
    reg "a" %arg{@}
    exec "A<ret><esc>|eval cat -- ""$kak_quoted_reg_a""<ret>"
  }
}

compl cat file
