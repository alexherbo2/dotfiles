hook global BufCreate ".+\.(cc|hh)" %{
  set buffer filetype "cpp"
}

hook global BufSetOption "filetype=cpp" %{
  add-highlighter buffer/cpp regions
  set buffer line_comment_token "//"
  set buffer block_comment_tokens "/*" "*/"
  hook -always -once buffer BufSetOption "filetype=.*" %{
    remove-highlighter buffer/cpp
  }
}
