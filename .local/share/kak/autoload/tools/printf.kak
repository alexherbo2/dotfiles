# name: kakoune_printf
# version: 0.1.0
# description: This script provides support for the printf command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
def -docstring '
usage: printf [args]
description: format selected text with the printf utility.
config_options: []
' printf -params .. %{
  eval -save-regs "a" %{
    reg "a" %arg{@}
    exec "|eval printf -- ""$kak_quoted_selection"" ""$kak_quoted_reg_a""<ret>"
  }
}
