hook global BufSetOption "filetype=prolog" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "prolog"
}
