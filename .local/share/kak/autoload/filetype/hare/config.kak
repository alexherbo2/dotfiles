hook global BufCreate ".+\.ha" %{
  set buffer filetype "hare"
}

hook global BufSetOption "filetype=hare" %{
  add-highlighter buffer/hare ref hare
  set buffer increase_indent_pattern %opt{increase_indent_pattern}
  set buffer decrease_indent_pattern %opt{decrease_indent_pattern}
  set buffer ignore_indent_pattern %opt{ignore_indent_pattern}
  set buffer line_comment_token "//"
  set buffer extra_word_chars %opt{extra_word_chars}
  set buffer static_words %opt{static_words}
  hook -always -once buffer BufSetOption "filetype=.*" %{
    remove-highlighter buffer/hare
  }
}
