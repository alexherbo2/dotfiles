hook global BufSetOption "filetype=ini" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "ini"
}
