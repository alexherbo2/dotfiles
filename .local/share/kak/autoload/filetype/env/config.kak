hook global BufCreate ".+\.env" %{
  set buffer filetype "env"
}

hook global BufSetOption "filetype=env" %{
}
