hook global BufSetOption "filetype=yaml" %{
  set buffer lsp_servers 'yaml-language-server = { command = "yaml-language-server", args = ["--stdio"], root_globs = [".git"] }'
  set buffer lsp_language_id "yaml"
}
