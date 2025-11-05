# name: kakoune_grep
# version: 0.1.0
# description: This script provides support for the grep command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
declare-option str grep_command grep
declare-option str-list grep_args -R -H -n

define-command grep -params .. %{
  evaluate-commands -save-regs '"' %{
    try %{
      execute-keys -buffer '*grep*' -save-regs '' '%y'
    } catch %{
      set-register dquote
    }
    fifo -name '*grep*' -- %opt{grep_command} %opt{grep_args} %arg{@}
    execute-keys -buffer '*grep*' 'P'
  }
}

complete-command grep file

define-command -hidden jump_to_references %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>Hs^(.+?):(\d+):(\d+):(.+?)$<ret>'
    evaluate-commands -itersel %{
      evaluate-commands -client %val{client} -verbatim edit -existing -- %reg{1} %reg{2} %reg{3}
    }
  }
}
