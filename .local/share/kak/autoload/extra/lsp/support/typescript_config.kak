hook global BufSetOption "filetype=typescript" %{
  set buffer lsp_servers 'tsc = { command = "tsc", args = ["--lsp", "--stdio"] }'
  set buffer lsp_language_id "typescript"
}
