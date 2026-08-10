hook global BufSetOption "filetype=sql" %{
  set buffer tree_sitter_lang "sql"
}
