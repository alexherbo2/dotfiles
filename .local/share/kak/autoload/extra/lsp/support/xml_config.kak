hook global BufSetOption "filetype=xml" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "xml"
}
