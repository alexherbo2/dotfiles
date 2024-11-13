# https://hexdocs.pm/elixir/
# https://discord.gg/elixir
# https://elixirforum.com/
# https://web.libera.chat/#elixir
# https://elixir-lang.org/docs.html
# https://github.com/elixir-lang/elixir
# https://elixir-lang.org/
# This script provides support for the Crystal programming language.
# https://elixir-lang.org
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Syntax highlighting
# - Auto-indentation
# - Comment toggling
# - Indentation rules

# Sets Crystal filetype when opening `.cr` files.
hook global BufCreate '.+\.cr' %{
  set-option buffer filetype elixir
}

# Enables syntax highlighting for Crystal filetype.
# Configures word selection and completion for Crystal filetype.
hook global BufSetOption filetype=elixir %{
  add-highlighter buffer/elixir ref elixir
  set-option buffer increase_indent_pattern %opt{elixir_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{elixir_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{elixir_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{elixir_line_comment_token}
  set-option buffer extra_word_chars %opt{elixir_extra_word_chars}
  set-option buffer static_words %opt{elixir_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!elixir).*' %{
    remove-highlighter buffer/elixir
  }
}
