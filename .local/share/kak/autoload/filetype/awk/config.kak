hook global BufCreate ".+\.(awk|gawk|nawk|mawk)" %{
  set buffer filetype "awk"
}

hook global BufSetOption "filetype=awk" %{
  add-highlighter buffer/awk regions
  set buffer increase_indent_pattern %opt{increase_indent_pattern}
  set buffer decrease_indent_pattern %opt{decrease_indent_pattern}
  set buffer ignore_indent_pattern %opt{ignore_indent_pattern}
  set buffer line_comment_token "#"
  set buffer extra_word_chars %opt{extra_word_chars}
  set buffer static_words %opt{static_words}
  hook -always -once buffer BufSetOption "filetype=.*" %{
    remove-highlighter buffer/awk
  }
}
