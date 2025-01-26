# name: kakoune_unimpaired_mode
# version: 0.1.0
# description: This script provides Vim-like unimpaired mappings.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
define-command hide_line_numbers %{
  add-highlighter global/line_numbers number-lines -hlcursor
}

define-command disable_readonly_mode %{
  set-option buffer readonly no
}

define-command hide_non_ascii_character_highlights %{
  remove-highlighter global/non_ascii_character_highlights
}

define-command hide_whitespace_highlights %{
  remove-highlighter global/whitespace_highlights
}

define-command hide_whitespace %{
  remove-highlighter global/whitespace
}

define-command disable_soft_wrap %{
  remove-highlighter global/soft_wrap
}
