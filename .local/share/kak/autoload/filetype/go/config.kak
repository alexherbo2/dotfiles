hook global BufCreate ".+\.go" %{
  set buffer filetype "go"
}

hook global BufSetOption "filetype=go" %{
}
