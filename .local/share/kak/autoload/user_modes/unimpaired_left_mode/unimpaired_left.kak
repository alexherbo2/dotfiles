# name: kakoune_unimpaired_mode
# version: 0.1.0
# description: This script provides Vim-like unimpaired mappings.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def hide_matching_brackets %{
  remove-highlighter global/match_brackets
}

def hide_line_numbers %{
  remove-highlighter global/line_numbers
}

def hide_rulers %{
  remove-highlighter global/rulers
}

def hide_search_highlights %{
  remove-highlighter global/search_highlights
}

def hide_selected_text_highlights %{
  remove-highlighter global/selected_text_highlights
}

def hide_non_ascii_character_highlights %{
  remove-highlighter global/non_ascii_character_highlights
}

def hide_whitespace_highlights %{
  remove-highlighter global/whitespace_highlights
}

def hide_hex_color_code_highlights %{
  remove-highlighter global/hex_color_code_highlights
}

def hide_whitespace_characters %{
  remove-highlighter global/whitespace_characters
}

def disable_readonly_mode %{
  set-option buffer readonly no
}

def disable_soft_wrap %{
  remove-highlighter global/soft_wrap
}

def jump_to_previous_file_or_directory %{
  buffer '*ls*'
  exec ',;kgh'
  jump_to_files_or_directories
}

def jump_to_previous_file_match %{
  buffer '*find*'
  exec ',;kgh'
  jump_to_files
}

def jump_to_previous_reference %{
  buffer '*grep*'
  exec ',;kgh'
  jump_to_references
}
