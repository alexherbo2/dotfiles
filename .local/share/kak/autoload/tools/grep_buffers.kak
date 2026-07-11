# name: kakoune_grep_buffers
# version: 0.1.0
# description: This script provides the functionality to grep buffers.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
def grep_buffers -params 1 %{
  eval -save-regs '"' %{
    try %{
      exec -buffer '*grep*' -save-regs '' '%y'
    } catch %{
      reg dquote
    }
    edit! -scratch -- '*grep*'
    edit! -scratch -debug -- '*grep_tmp*'
    eval -no-hooks -buffer '*' -verbatim -- try %{
      exec '%s<ret><a-;>'
      eval -itersel -save-regs 'ab' %{
        reg a "%val{bufname}:%val{cursor_line}:%val{cursor_column}:"
        exec 'x<a-:>H"by'
        exec -buffer '*grep_tmp*' 'ge"apH"bp<a-j>'
      }
    }
    exec 'd%y:db<ret>Rgg'
    exec -buffer '*grep*' 'P'
  }
}
