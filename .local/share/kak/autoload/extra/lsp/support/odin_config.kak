hook global BufSetOption "filetype=odin" %{
  set buffer lsp_servers 'ols = { command = "ols", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "odin"
}
