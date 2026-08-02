hook global BufSetOption "filetype=html" %{
  set buffer lsp_servers 'vscode-html-language-server = { command = "vscode-html-language-server", args = ["--stdio"], root_globs = [".git"] }'
  set buffer lsp_language_id "html"
}
