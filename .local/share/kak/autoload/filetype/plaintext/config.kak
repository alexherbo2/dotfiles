hook global BufCreate ".+\.txt" %{
  set buffer filetype "plaintext"
}

hook global BufSetOption "filetype=plaintext" %{
}
