hook global BufCreate ".+\.fish" %{
  set buffer filetype "fish"
}

hook global BufSetOption "filetype=fish" %{
}
