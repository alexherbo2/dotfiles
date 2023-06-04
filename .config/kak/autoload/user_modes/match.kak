# https://docs.helix-editor.com/keymap.html#match-mode
declare-user-mode match

define-command enter_match_mode %{
  enter-user-mode match
}

map -docstring 'select next matching brackets' global match m m
map -docstring 'select previous matching brackets' global match p <a-m>
map -docstring 'select inner surrounding objects' global match i <a-i>
map -docstring 'select whole surrounding objects' global match a <a-a>
