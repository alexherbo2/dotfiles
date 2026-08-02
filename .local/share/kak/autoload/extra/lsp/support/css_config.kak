hook global BufSetOption "filetype=css" %{
  set buffer lsp_servers 'vscode-css-language-server = { command = "vscode-css-language-server", args = ["--stdio"], root_globs = [".git"] }'
  set buffer lsp_language_id "css"
}
