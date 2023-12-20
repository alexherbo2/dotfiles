# name: kakoune_match_mode
# version: 0.1.0
# description: "This script provides access to the match mode.\nThese mappings are in the style of Helix’s match mode.\nHelix’s match mode: https://docs.helix-editor.com/keymap.html#match-mode"
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["enter_surround_mode", "enter_select_inner_object_mode", "enter_select_whole_object_mode", "enter_select_previous_object_mode", "enter_select_next_object_mode"]
# doc: yes
# tests: no
declare-user-mode match

define-command enter_match_mode %{
  enter-user-mode match
}

map -docstring 'select next matching brackets' global match m m
map -docstring 'select previous matching brackets' global match M <a-m>
map -docstring 'select inner surrounding objects' global match i <a-i>
map -docstring 'select whole surrounding objects' global match a <a-a>
map -docstring 'enter surround mode' global match s ':enter_surround_mode<ret>'
map -docstring 'select inner objects' global match I ':enter_select_inner_object_mode<ret>'
map -docstring 'select whole objects' global match A ':enter_select_whole_object_mode<ret>'
map -docstring 'select previous surrounding object' global match p ':enter_select_previous_object_mode<ret>'
map -docstring 'select next surrounding object' global match n ':enter_select_next_object_mode<ret>'
