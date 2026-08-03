hook global BufSetOption "filetype=nu" %{
  set buffer lsp_servers 'nu = { command = "nu", args = ["--lsp"], root_globs = [".git"] }'
  set buffer lsp_language_id "nu"
}
