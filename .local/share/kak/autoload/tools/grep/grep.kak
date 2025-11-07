# name: kakoune_grep
# version: 0.1.0
# description: This script provides support for the grep command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
decl str grep_command grep
decl str-list grep_args -R -H -n

def grep -params .. %{
  eval -save-regs '"' %{
    try %{
      exec -buffer '*grep*' -save-regs '' '%y'
    } catch %{
      reg dquote
    }
    fifo -name '*grep*' -- %opt{grep_command} %opt{grep_args} %arg{@}
    exec -buffer '*grep*' 'P'
  }
}

complete-command grep file

def -hidden jump_to_references %{
  eval -draft %{
    exec 'x<a-s><a-K>^\n<ret>Hs^(.+?):(\d+):(\d+):(.+?)$<ret>'
    eval -itersel %{
      eval -client %val{client} -verbatim edit -existing -- %reg{1} %reg{2} %reg{3}
    }
  }
}
