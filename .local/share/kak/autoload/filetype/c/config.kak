hook global BufCreate ".+\.(c|h)" %{
  set buffer filetype "c"
}

hook global BufSetOption "filetype=c" %{
  add-highlighter buffer/c regions
  set buffer line_comment_token "//"
  set buffer block_comment_tokens "/*" "*/"
  hook -always -once buffer BufSetOption "filetype=.*" %{
    remove-highlighter buffer/c
  }
}
