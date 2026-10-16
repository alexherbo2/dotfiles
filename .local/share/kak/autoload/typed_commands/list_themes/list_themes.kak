# name: kakoune_list_themes
# version: 0.1.0
# description: This script provides the functionality to list themes.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def -docstring '
usage: list-themes
description: list themes.
config_options: []
' list-themes %{
  fifo -name '*themes*' find -L -- "%val{config}/themes" "%val{runtime}/themes" -type f -name "*.kak" -exec basename -a -s ".kak" -- {} +
}

def -hidden load_selected_theme_name %{
  eval -draft %{
    select_theme_name_entries 1
    theme %val{selection}
  }
}

def -hidden select_theme_name_entries -params 1 %{
  exec "x<a-s>%arg{1}s\A(.+?)\n\z<ret>"
}
