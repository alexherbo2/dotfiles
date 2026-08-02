hook global BufSetOption "filetype=kotlin" %{
  set buffer lsp_servers 'kotlin-language-server = { command = "kotlin-language-server", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "kotlin"
}
