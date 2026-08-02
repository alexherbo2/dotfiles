hook global BufSetOption "filetype=c" %{
  set buffer lsp_servers 'clangd = { command = "clangd", args = [] }'
  set buffer lsp_language_id "c"
}
