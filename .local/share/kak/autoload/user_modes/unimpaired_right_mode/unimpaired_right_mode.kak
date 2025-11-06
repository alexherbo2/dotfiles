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

map -docstring 'show line numbers' global unimpaired_right l ':show_line_numbers<ret>'
map -docstring 'show non ascii character highlights' global unimpaired_right C ':show_non_ascii_character_highlights<ret>'
map -docstring 'show whitespace highlights' global unimpaired_right W ':show_whitespace_highlights<ret>'
map -docstring 'show whitespace' global unimpaired_right w ':show_whitespace<ret>'
map -docstring 'enable soft-wrap mode' global unimpaired_right <tab> ':enable_soft_wrap<ret>'
map -docstring 'enable read-only mode' global unimpaired_right r ':enable_readonly_mode<ret>'
map -docstring 'add new line below' global unimpaired_right <space> <a-o>
map -docstring 'jump to next buffer' global unimpaired_right b ':buffer-next<ret>'
map -docstring 'jump to next file in directory' global unimpaired_right n ':jump_to_next_file_or_directory<ret>'
map -docstring 'jump to next reference' global unimpaired_right g ':jump_to_next_reference<ret>'
map -docstring 'jump to next file match' global unimpaired_right f ':jump_to_next_file_match<ret>'
