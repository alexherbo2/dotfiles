# name: kakoune_find
# version: 0.1.0
# description: This script provides support for the find command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
decl -docstring '
find_command = "find"
' str find_command 'find'

decl -docstring '
find_args = [".", "-type", "f"]
' str-list find_args '.' '-type' 'f'

def -docstring '
command: find [options] [paths] [expression]
kakoune_options: ["find_command", "find_args"]
' find -params .. %{
  eval -save-regs '"' %{
    try %{
      exec -buffer '*find*' -save-regs '' '%y'
    } catch %{
      reg '"'
    }
    fifo -name '*find*' -- %opt{find_command} %opt{find_args} %arg{@}
    exec -buffer '*find*' 'P'
  }
}

complete-command find file

def -hidden jump_to_files %{
  eval -draft %{
    exec 'x<a-s><a-K>^\n<ret>H'
    eval -itersel %{
      eval -client %val{client} -verbatim edit -existing -- %val{selection}
    }
  }
}

def -hidden select_find_entries -params 1 %{
  exec "x<a-s>%arg{1}s\A(.+?)\n\z<ret>"
}
