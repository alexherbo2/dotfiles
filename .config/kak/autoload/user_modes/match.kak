# https://docs.helix-editor.com/keymap.html#match-mode
declare-user-mode match

define-command enter_match_mode %{
  enter-user-mode match
}

map -docstring 'select next matching brackets' global match m m
map -docstring 'select previous matching brackets' global match M <a-m>
map -docstring 'select inner surrounding objects' global match i <a-i>
map -docstring 'select whole surrounding objects' global match a <a-a>
map -docstring 'enter surround mode' global match s ':enter_surround_mode<ret>'
map -docstring 'enter select mode' global match I ':enter_select_mode<ret>'
map -docstring 'select previous surrounding object' global match p ':enter_select_previous_object_mode<ret>'
map -docstring 'select next surrounding object' global match n ':enter_select_next_object_mode<ret>'
