hook global BufCreate ".+\.(kt|kts)" %{
  set buffer filetype "kotlin"
}

hook global BufSetOption "filetype=kotlin" %{
}
