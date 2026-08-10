hook global BufCreate ".+\.sql" %{
  set buffer filetype "sql"
}

hook global BufSetOption "filetype=sql" %{
}
