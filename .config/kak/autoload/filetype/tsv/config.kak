# This script provides support for the Crystal programming language.
# https://tsv-lang.org
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Syntax highlighting
# - Auto-indentation
# - Comment toggling
# - Indentation rules

# Sets Crystal filetype when opening `.tsv` files.
hook global BufCreate '.+\.tsv' %{
  set-option buffer filetype tsv
}

# Enables syntax highlighting for Crystal filetype.
# Configures word selection and completion for Crystal filetype.
hook global BufSetOption filetype=tsv %{
  add-highlighter buffer/tsv ref tsv
  set-option buffer increase_indent_pattern %opt{tsv_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{tsv_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{tsv_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{tsv_line_comment_token}
  set-option buffer extra_word_chars %opt{tsv_extra_word_chars}
  set-option buffer static_words %opt{tsv_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!tsv).*' %{
    remove-highlighter buffer/tsv
  }
}
