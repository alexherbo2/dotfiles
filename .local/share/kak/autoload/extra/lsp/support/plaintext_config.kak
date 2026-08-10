hook global BufSetOption "filetype=plaintext" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "plaintext"
}
