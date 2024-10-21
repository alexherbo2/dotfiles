# name: kakoune_unimpaired_mode
# version: 0.1.0
# description: This script provides Vim-like unimpaired mappings.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
declare-user-mode unimpaired_right

define-command enter_unimpaired_right_mode %{
  enter-user-mode unimpaired_right
}

define-command enter_sticky_unimpaired_right_mode %{
  enter-user-mode -lock unimpaired_right
}

define-command show_line_numbers %{
  add-highlighter global/line_numbers number-lines -hlcursor
}

define-command enable_readonly_mode %{
  set-option buffer readonly yes
}

define-command show_whitespace %{
  add-highlighter global/whitespace show-whitespaces
}

define-command enable_soft_wrap %{
  add-highlighter global/soft_wrap wrap -indent -marker '↪'
}

map -docstring 'show line numbers' global unimpaired_right l ':show_line_numbers<ret>'
map -docstring 'show whitespace' global unimpaired_right w ':show_whitespace<ret>'
map -docstring 'enable soft-wrap mode' global unimpaired_right <tab> ':enable_soft_wrap<ret>'
map -docstring 'enable read-only mode' global unimpaired_right r ':enable_readonly_mode<ret>'
map -docstring 'add new line below' global unimpaired_right <space> <a-o>
map -docstring 'jump to next buffer' global unimpaired_right b ':buffer-next<ret>'
