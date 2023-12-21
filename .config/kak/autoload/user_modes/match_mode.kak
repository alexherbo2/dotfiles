# name: kakoune_match_mode
# version: 0.1.0
# description: "This script provides access to the match mode.\nThese mappings are in the style of Helix’s match mode.\nHelix’s match mode: https://docs.helix-editor.com/keymap.html#match-mode"
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["enter_surround_mode", "enter_select_mode"]
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
map -docstring 'enter select mode' global match S ':enter_select_mode<ret>'
