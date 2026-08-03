hook global BufCreate ".+\.gleam" %{
  set buffer filetype "gleam"
}

hook global BufSetOption "filetype=gleam" %{
}
