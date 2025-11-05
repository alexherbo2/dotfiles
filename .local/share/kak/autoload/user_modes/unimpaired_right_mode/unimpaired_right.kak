# name: kakoune_unimpaired_mode
# version: 0.1.0
# description: This script provides Vim-like unimpaired mappings.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def show_line_numbers %{
  add-highlighter global/line_numbers number-lines -hlcursor -separator '  '
}

def enable_readonly_mode %{
  set-option buffer readonly yes
}

def show_non_ascii_character_highlights %{
  add-highlighter global/non_ascii_character_highlights ref non_ascii_characters
}

def show_whitespace_highlights %{
  add-highlighter global/whitespace_highlights ref whitespace
}

def show_whitespace %{
  add-highlighter global/whitespace show-whitespaces
}

def enable_soft_wrap %{
  add-highlighter global/soft_wrap wrap -indent -marker '↪'
}

def jump_to_next_file_or_directory %{
  buffer '*ls*'
  exec ',;jgh'
  jump_to_files_or_directories
}

def jump_to_next_file %{
  buffer '*find*'
  exec ',;jgh'
  jump_to_files
}

def jump_to_next_reference %{
  buffer '*grep*'
  exec ',;jgh'
  jump_to_references
}
