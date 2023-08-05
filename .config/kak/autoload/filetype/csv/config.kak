# This script provides support for the Crystal programming language.
# https://csv-lang.org
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Syntax highlighting
# - Auto-indentation
# - Comment toggling
# - Indentation rules

# Sets Crystal filetype when opening `.csv` files.
hook global BufCreate '.+\.csv' %{
  set-option buffer filetype csv
}

# Enables syntax highlighting for Crystal filetype.
# Configures word selection and completion for Crystal filetype.
hook global BufSetOption filetype=csv %{
  add-highlighter buffer/csv ref csv
  set-option buffer increase_indent_pattern %opt{csv_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{csv_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{csv_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{csv_line_comment_token}
  set-option buffer extra_word_chars %opt{csv_extra_word_chars}
  set-option buffer static_words %opt{csv_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!csv).*' %{
    remove-highlighter buffer/csv
  }
}
