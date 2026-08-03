hook global BufCreate ".+\.jsx" %{
  set buffer filetype "jsx"
}

hook global BufSetOption "filetype=jsx" %{
}
