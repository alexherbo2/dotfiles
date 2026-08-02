hook global BufSetOption "filetype=json" %{
  set buffer lsp_servers 'vscode-json-language-server = { command = "vscode-json-language-server", args = ["--stdio"], root_globs = [".git"] }'
  set buffer lsp_language_id "json"
}
