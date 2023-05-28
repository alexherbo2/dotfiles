# This script provides support for the Crystal programming language.
# https://crystal-lang.org
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Syntax highlighting
# - Auto-indentation
# - Comment toggling
# - Indentation rules

# Sets Crystal filetype when opening `.cr` files.
hook global BufCreate '.+\.cr' %{
  set-option buffer filetype crystal
}

# Enables syntax highlighting for Crystal filetype.
# Configures word selection and completion for Crystal filetype.
hook global BufSetOption filetype=crystal %{
  add-highlighter buffer/crystal ref crystal
  set-option buffer increase_indent_pattern %opt{crystal_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{crystal_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{crystal_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{crystal_line_comment_token}
  set-option buffer extra_word_chars %opt{crystal_extra_word_chars}
  set-option buffer static_words %opt{crystal_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!crystal).*' %{
    remove-highlighter buffer/crystal
  }
}
