hook global BufSetOption "filetype=jsdoc" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "jsdoc"
}
