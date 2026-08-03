hook global BufCreate ".+\.elv" %{
  set buffer filetype "elvish"
}

hook global BufSetOption "filetype=elvish" %{
}
