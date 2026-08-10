hook global BufSetOption "filetype=env" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "env"
}
