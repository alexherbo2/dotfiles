hook global BufSetOption "filetype=diff" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "diff"
}
