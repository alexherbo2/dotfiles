# name: kakoune_grep
# version: 0.1.0
# description: This script provides support for the grep command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
decl -docstring '
grep_command: "grep"
' str grep_command 'grep'

decl -docstring '
grep_args: ["-R", "-I", "-H", "-n"]
' str-list grep_args '-R' '-I' '-H' '-n'

def -docstring '
usage: grep [options] [pattern] [paths]
config_options: ["grep_command", "grep_args"]
' grep -params .. %{
  fifo -append -name '*grep*' -- %opt{grep_command} %opt{grep_args} %arg{@}
}

complete-command grep file

def -hidden jump_to_references %{
  eval -no-hooks -draft %{
    select_grep_entries 0
    eval -itersel %{
      eval -client %val{client} -verbatim edit -existing -- %reg{1} %reg{2}
      exec -client %val{client} 'x'
    }
  }
}

def -hidden select_grep_entries -params 1 %{
  exec "x<a-s>%arg{1}s\A(.+?):(\d+):(.*?\n)\z<ret>"
}
