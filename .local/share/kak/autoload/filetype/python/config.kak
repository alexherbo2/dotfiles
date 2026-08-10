hook global BufCreate ".+\.py" %{
  set buffer filetype "python"
}

hook global BufSetOption "filetype=python" %{
  set buffer line_comment_token "#"
}
