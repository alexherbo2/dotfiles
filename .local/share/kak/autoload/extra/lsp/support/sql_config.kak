hook global BufSetOption "filetype=sql" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "sql"
}
