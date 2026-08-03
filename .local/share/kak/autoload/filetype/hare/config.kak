hook global BufCreate ".+\.ha" %{
  set buffer filetype "hare"
}

hook global BufSetOption "filetype=hare" %{
}
