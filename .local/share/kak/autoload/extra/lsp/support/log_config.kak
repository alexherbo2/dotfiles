hook global BufSetOption "filetype=log" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "log"
}
