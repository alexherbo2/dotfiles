hook global BufSetOption "filetype=jq" %{
  set buffer lsp_servers 'jq-lsp = { command = "jq-lsp", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "jq"
}
