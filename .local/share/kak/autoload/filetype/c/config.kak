hook global BufCreate ".+\.(c|h)" %{
  set buffer filetype "c"
}

hook global BufSetOption "filetype=c" %{
  add-highlighter buffer/c regions
  set buffer increase_indent_pattern %opt{increase_indent_pattern}
  set buffer decrease_indent_pattern %opt{decrease_indent_pattern}
  set buffer ignore_indent_pattern %opt{ignore_indent_pattern}
  set buffer line_comment_token "//"
  set buffer block_comment_tokens "/*" "*/"
  set buffer extra_word_chars %opt{extra_word_chars}
  set buffer static_words %opt{static_words}
  hook -always -once buffer BufSetOption "filetype=.*" %{
    remove-highlighter buffer/c
  }
}
