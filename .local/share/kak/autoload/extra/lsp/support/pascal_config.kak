hook global BufSetOption "filetype=pascal" %{
  set buffer lsp_servers 'pasls = { command = "pasls", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "pascal"
}
