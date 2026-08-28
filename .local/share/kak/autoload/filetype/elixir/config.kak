hook global BufCreate ".+\.(?:ex|exs)" %{
  set buffer filetype "elixir"
}

hook global BufSetOption "filetype=elixir" %{
  add-highlighter buffer/elixir ref elixir
  set buffer increase_indent_pattern %opt{increase_indent_pattern}
  set buffer decrease_indent_pattern %opt{decrease_indent_pattern}
  set buffer ignore_indent_pattern %opt{ignore_indent_pattern}
  set buffer line_comment_token "#"
  set buffer extra_word_chars "_" "?" "!"
  set buffer static_words %opt{static_words}
  hook -always -once buffer BufSetOption "filetype=.*" %{
    remove-highlighter buffer/elixir
  }
}
