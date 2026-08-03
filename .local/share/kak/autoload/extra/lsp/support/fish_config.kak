hook global BufSetOption "filetype=fish" %{
  set buffer lsp_servers 'fish-lsp = { command = "fish-lsp", args = ["start"], root_globs = [".git"] }'
  set buffer lsp_language_id "fish"
}
