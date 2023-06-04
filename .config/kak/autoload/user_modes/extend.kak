# https://docs.helix-editor.com/keymap.html#extend-mode
declare-user-mode extend

define-command enter_extend_mode %{
  enter-user-mode -lock extend
}

map -docstring 'left' global extend h H
map -docstring 'down' global extend j J
map -docstring 'up' global extend k K
map -docstring 'right' global extend l L
map -docstring 'next word start' global extend w W
map -docstring 'next word end' global extend e E
map -docstring 'previous word start' global extend b B
map -docstring 'next long word start' global extend W <a-W>
map -docstring 'next long word end' global extend E <a-E>
map -docstring 'previous long word start' global extend B <a-B>
map -docstring 'next match' global extend n N
map -docstring 'previous match' global extend N <a-N>
map -docstring 'flip selections' global extend ';' '<a-;>'
