# name: kakoune_iterate_selections
# version: 0.1.0
# description: This script provides the functionality to iterate selections individually.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
define-command -hidden iterate_next_selection -params 2 %{
  execute-keys -save-regs '' """%arg{1}z%arg{2})""%arg{1}<a-z>a""%arg{1}Z,"
}

define-command -hidden iterate_previous_selection -params 2 %{
  execute-keys -save-regs '' """%arg{1}z%arg{2}(""%arg{1}<a-z>a""%arg{1}Z,"
}
