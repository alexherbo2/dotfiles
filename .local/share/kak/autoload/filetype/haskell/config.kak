hook global BufCreate ".+\.(hs|hsc)" %{
  set buffer filetype "haskell"
}

hook global BufSetOption "filetype=haskell" %{
}
