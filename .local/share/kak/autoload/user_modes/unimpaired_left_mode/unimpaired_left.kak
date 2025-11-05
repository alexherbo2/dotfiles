# name: kakoune_unimpaired_mode
# version: 0.1.0
# description: This script provides Vim-like unimpaired mappings.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def hide_line_numbers %{
  add-highlighter global/line_numbers number-lines -hlcursor
}

def disable_readonly_mode %{
  set-option buffer readonly no
}

def hide_non_ascii_character_highlights %{
  remove-highlighter global/non_ascii_character_highlights
}

def hide_whitespace_highlights %{
  remove-highlighter global/whitespace_highlights
}

def hide_whitespace %{
  remove-highlighter global/whitespace
}

def disable_soft_wrap %{
  remove-highlighter global/soft_wrap
}

def jump_to_previous_file_or_directory %{
  buffer '*ls*'
  exec ',;kgh'
  jump_to_files_or_directories
}

def jump_to_previous_file %{
  try %{
    buffer '*find*'
    exec ',;kgh'
    jump_to_files
  } catch %{
    explore
  }
}

def jump_to_previous_reference %{
  buffer '*grep*'
  exec ',;kgh'
  jump_to_references
}
