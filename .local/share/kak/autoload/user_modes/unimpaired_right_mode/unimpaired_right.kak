# name: kakoune_unimpaired_mode
# version: 0.1.0
# description: This script provides Vim-like unimpaired mappings.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def show_matching_brackets %{
  add-highlighter global/match_brackets ref match_brackets
}

def show_line_numbers %{
  add-highlighter global/line_numbers ref -passes move line_numbers
}

def show_rulers %{
  add-highlighter global/rulers ref rulers
}

def show_search_highlights %{
  add-highlighter global/search_highlights ref search_highlights
}

def show_selected_text_highlights %{
  add-highlighter global/selected_text_highlights ref selected_text_highlights
}

def show_non_ascii_character_highlights %{
  add-highlighter global/non_ascii_character_highlights ref non_ascii_character_highlights
}

def show_whitespace_highlights %{
  add-highlighter global/whitespace_highlights ref whitespace_highlights
}

def show_hex_color_code_highlights %{
  add-highlighter global/hex_color_code_highlights ref hex_color_code_highlights
}

def show_whitespace_characters %{
  add-highlighter global/whitespace_characters ref -passes replace whitespace_characters
}

def enable_readonly_mode %{
  set-option buffer readonly yes
}

def enable_soft_wrap %{
  add-highlighter global/soft_wrap ref -passes wrap soft_wrap
}

def jump_to_next_file_or_directory %{
  buffer '*ls*'
  exec ',;jgh'
  jump_to_files_or_directories
}

def jump_to_next_file_match %{
  buffer '*find*'
  exec ',;jgh'
  jump_to_files
}

def jump_to_next_reference %{
  buffer '*grep*'
  exec ',;jgh'
  jump_to_references
}
