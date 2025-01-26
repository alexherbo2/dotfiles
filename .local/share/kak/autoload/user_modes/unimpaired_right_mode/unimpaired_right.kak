# name: kakoune_unimpaired_mode
# version: 0.1.0
# description: This script provides Vim-like unimpaired mappings.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
define-command show_line_numbers %{
  add-highlighter global/line_numbers number-lines -hlcursor -separator '  '
}

define-command enable_readonly_mode %{
  set-option buffer readonly yes
}

define-command show_non_ascii_character_highlights %{
  add-highlighter global/non_ascii_character_highlights ref non_ascii_characters
}

define-command show_whitespace_highlights %{
  add-highlighter global/whitespace_highlights ref whitespace
}

define-command show_whitespace %{
  add-highlighter global/whitespace show-whitespaces
}

define-command enable_soft_wrap %{
  add-highlighter global/soft_wrap wrap -indent -marker '↪'
}
