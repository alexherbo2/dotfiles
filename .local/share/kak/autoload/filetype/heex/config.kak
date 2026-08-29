hook global BufCreate ".+\.heex" %{
  set buffer filetype "heex"
}

hook global BufSetOption "filetype=heex" %{
  add-highlighter buffer/heex ref eex
  set buffer increase_indent_pattern %opt{increase_indent_pattern}
  set buffer decrease_indent_pattern %opt{decrease_indent_pattern}
  set buffer ignore_indent_pattern %opt{ignore_indent_pattern}
  set buffer block_comment_tokens "<!--" "-->"
  set buffer extra_word_chars %opt{extra_word_chars}
  set buffer static_words %opt{static_words}
  hook -always -once buffer BufSetOption "filetype=.*" %{
    remove-highlighter buffer/heex
  }
}
