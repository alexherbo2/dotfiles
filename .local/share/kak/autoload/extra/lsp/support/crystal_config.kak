hook global BufSetOption "filetype=crystal" %{
  set buffer lsp_servers 'crystalline = { command = "crystalline", args = ["--stdio"], root_globs = ["shard.yml"] }'
  set buffer lsp_language_id "crystal"
}
