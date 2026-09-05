hook global BufSetOption "filetype=fennel" %{
  set buffer lsp_servers 'fennel-ls = { command = "fennel-ls", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "fennel"
}
