# name: kakoune_grep
# version: 0.1.0
# description: This script provides support for the grep command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
def -hidden grep_impl -params .. %{
  eval -save-regs '"' %{
    try %{
      exec -buffer '*grep*' -save-regs '' '%y'
    } catch %{
      reg '"'
    }
    fifo -name '*grep*' -- %opt{grep_command} %opt{grep_args} %arg{@}
    exec -buffer '*grep*' 'P'
  }
}

def -hidden jump_to_references %{
  eval -no-hooks -draft %{
    exec 'x<a-s>s\A(.+?):(\d+):(?:.*?\n)\z<ret>'
    eval -itersel %{
      eval -client %val{client} -verbatim edit -existing -- %reg{1} %reg{2}
      exec -client %val{client} 'x'
    }
  }
}

def -hidden select_grep_entries -params 1 %{
  exec "x<a-s>%arg{1}s\A(.+?):(\d+):(.*?\n)\z<ret>"
}
