# name: kakoune_view
# version: 0.1.0
# description: This script provides the functionality to open files in read-only mode.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def -docstring "
usage: view
description: open file in read-only mode.
config_options: []
" view -params 1 %{
  edit -existing -readonly -- %arg{1}
}

alias global v view
