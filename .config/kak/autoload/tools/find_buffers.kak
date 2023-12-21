# name: kakoune_find_buffers
# version: 0.1.0
# description: This script provides the functionality to find buffers.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
define-command find_buffers -params 1 %{
  evaluate-commands -save-regs '"' %{
    try %{
      execute-keys -buffer '*find*' -save-regs '' '%y'
    } catch %{
      set-register dquote
    }
    edit! -scratch '*find*'
    evaluate-commands -save-regs '"/' %{
      set-register dquote %val{buflist}
      execute-keys '<a-R>a<ret><esc>'
      try %{
        set-register / %arg{1}
        execute-keys '<a-k><ret>y%<a-R>gg'
      } catch %{
        execute-keys '%d'
      }
    }
    execute-keys -buffer '*find*' 'P'
  }
}

complete-command find_buffers buffer
