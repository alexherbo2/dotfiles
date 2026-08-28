hook global BufCreate ".+\.fish" %{
  set buffer filetype "fish"
}

hook global BufSetOption "filetype=fish" %{
  add-highlighter buffer/fish ref fish
  set buffer increase_indent_pattern %opt{increase_indent_pattern}
  set buffer decrease_indent_pattern %opt{decrease_indent_pattern}
  set buffer ignore_indent_pattern %opt{ignore_indent_pattern}
  set buffer line_comment_token "#"
  set buffer extra_word_chars %opt{extra_word_chars}
  set buffer static_words %opt{static_words}
  hook -always -once buffer BufSetOption "filetype=.*" %{
    remove-highlighter buffer/fish
  }
}
