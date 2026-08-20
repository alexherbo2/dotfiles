hook global BufSetOption "filetype=asciidoc" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "asciidoc"
}
