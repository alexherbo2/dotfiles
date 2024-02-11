# name: kakoune_unimpaired_mode
# version: 0.1.0
# description: This script provides Vim-like unimpaired mappings.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
declare-user-mode unimpaired_left

define-command enter_unimpaired_left_mode %{
  enter-user-mode unimpaired_left
}

define-command enter_sticky_unimpaired_left_mode %{
  enter-user-mode -lock unimpaired_left
}

define-command hide_line_numbers %{
  add-highlighter global/line_numbers number-lines -hlcursor
}

define-command disable_readonly_mode %{
  set-option buffer readonly no
}

define-command hide_whitespace %{
  remove-highlighter global/whitespace
}

define-command disable_soft_wrap %{
  remove-highlighter global/soft_wrap
}

map -docstring 'hide line numbers' global unimpaired_left l ':hide_line_numbers<ret>'
map -docstring 'hide whitespace' global unimpaired_left w ':hide_whitespace<ret>'
map -docstring 'disable read-only mode' global unimpaired_left r ':disable_readonly_mode<ret>'
map -docstring 'disable soft-wrap' global unimpaired_left <tab> ':disable_soft_wrap<ret>'
map -docstring 'add new line above' global unimpaired_left <space> <a-O>
map -docstring 'jump to previous buffer' global unimpaired_left b ':buffer-previous<ret>'
