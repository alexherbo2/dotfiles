# name: kakoune_grep_write
# version: 0.1.0
# description: This script provides the functionality to apply changes to file buffers from grep results.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
def -hidden apply_changes_from_references %{
  eval -no-hooks -draft %{
    exec 'x<a-s>s\A(.+?):(\d+):(.*?\n)\z<ret>'
    eval -itersel -save-regs '"' %{
      eval -client %val{client} -verbatim edit -existing -- %reg{1} %reg{2}
      reg '"' %reg{3}
      exec -client %val{client} 'xR'
    }
  }
}
