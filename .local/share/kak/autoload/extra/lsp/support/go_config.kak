hook global BufSetOption "filetype=go" %{
  set buffer lsp_servers 'gopls = { command = "gopls", args = [], root_globs = ["go.mod", "go.work"] }'
  set buffer lsp_language_id "go"
}
