hook global BufSetOption "filetype=toml" %{
  set buffer lsp_servers 'taplo = { command = "taplo", args = ["lsp", "stdio"], root_globs = [".git"] }'
  set buffer lsp_language_id "toml"
}
