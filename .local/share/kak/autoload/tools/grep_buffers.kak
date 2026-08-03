# name: kakoune_grep_buffers
# version: 0.1.0
# description: This script provides the functionality to grep buffers.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
def -hidden grep_buffers -params 1 %{
  eval -save-regs '"' %{
    try %{
      exec -buffer 'kakoune://scratch/unnamed.refs' -save-regs '' '%y'
    } catch %{
      reg '"'
    }
    edit! -scratch 'kakoune://scratch/unnamed.refs'
    edit! -scratch -debug 'kakoune://scratch/a.refs'
    eval -no-hooks -buffer '*' -verbatim -- try %{
      exec '%s<ret>x<a-s>'
      eval -itersel -save-regs '"' %{
        reg '"' "%val{bufname}:%val{cursor_line}:%reg{.}"
        exec -buffer 'kakoune://scratch/a.refs' 'gep'
      }
    }
    exec 'd%y:db<ret>Rgg'
    exec -buffer 'kakoune://scratch/unnamed.refs' 'P'
  }
}
