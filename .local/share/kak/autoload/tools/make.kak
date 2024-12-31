# name: kakoune_make
# version: 0.1.0
# description: This script provides support for the make command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
declare-option str make_command make
declare-option str-list make_args

define-command make -params .. %{
  evaluate-commands -save-regs '"' %{
    try %{
      execute-keys -buffer '*make*' -save-regs '' '%y'
    } catch %{
      set-register dquote
    }
    fifo -name '*make*' -- %opt{make_command} %opt{make_args} %arg{@}
    execute-keys -buffer '*make*' 'P'
  }
}

complete-command make file
