hook global BufSetOption "filetype=elvish" %{
  set buffer lsp_servers 'elvish = { command = "elvish", args = ["-lsp"], root_globs = [".git"] }'
  set buffer lsp_language_id "elvish"
}
