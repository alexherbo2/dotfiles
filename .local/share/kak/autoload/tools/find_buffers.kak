# name: kakoune_find_buffers
# version: 0.1.0
# description: This script provides the functionality to find buffers.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
def -hidden find_buffers -params 1 %{
  eval -save-regs '"' %{
    try %{
      exec -buffer '*find*' -save-regs '' '%y'
    } catch %{
      reg '"'
    }
    edit! -scratch '*find*'
    eval -save-regs '"/' %{
      reg '"' %val{buflist}
      exec '<a-R>a<ret><esc>'
      try %{
        reg / %arg{1}
        exec '<a-k><ret>y%<a-R>gg'
      } catch %{
        exec '%d'
      }
    }
    exec -buffer '*find*' 'P'
  }
}

complete-command find_buffers buffer
