# name: kakoune_iterate_selections
# version: 0.1.0
# description: This script provides the functionality to iterate selections individually.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def -hidden iterate_next_selection -params 2 %{
  exec -save-regs '' """%arg{1}z%arg{2})""%arg{1}Z,"
}

def -hidden iterate_previous_selection -params 2 %{
  exec -save-regs '' """%arg{1}z%arg{2}(""%arg{1}Z,"
}
