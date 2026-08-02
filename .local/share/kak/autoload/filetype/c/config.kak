hook global BufCreate ".+\.(c|h)" %{
  set buffer filetype "c"
}

hook global BufSetOption "filetype=c" %{
}
