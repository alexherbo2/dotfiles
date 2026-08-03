hook global BufCreate ".+\.nu" %{
  set buffer filetype "nu"
}

hook global BufSetOption "filetype=nu" %{
}
