# name: kakoune_grep_buffers
# version: 0.1.0
# description: This script provides the functionality to grep buffers.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
define-command grep_buffers -params 1 %{
  evaluate-commands -save-regs '"' %{
    try %{
      execute-keys -buffer '*grep*' -save-regs '' '%y'
    } catch %{
      set-register dquote
    }
    edit! -scratch -- '*grep*'
    edit! -scratch -debug -- '*grep_tmp*'
    evaluate-commands -no-hooks -buffer '*' -verbatim -- try %{
      execute-keys '%s<ret><a-;>'
      evaluate-commands -itersel -save-regs 'ab' %{
        set-register a "%val{bufname}:%val{cursor_line}:%val{cursor_column}:"
        execute-keys 'x<a-:>H"by'
        execute-keys -buffer '*grep_tmp*' 'ge"apH"bp<a-j>'
      }
    }
    execute-keys 'd%y:delete-buffer<ret>Rgg'
    execute-keys -buffer '*grep*' 'P'
  }
}
