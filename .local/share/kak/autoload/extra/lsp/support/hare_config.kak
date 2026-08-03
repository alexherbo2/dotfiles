hook global BufSetOption "filetype=hare" %{
  set buffer lsp_servers 'hare-lsp = { command = "hare-lsp", args = ["-S"], root_globs = [".git"] }'
  set buffer lsp_language_id "hare"
}
