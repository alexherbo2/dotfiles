hook global BufSetOption "filetype=csharp" %{
  set buffer lsp_servers 'roslyn-language-server = { command = "roslyn-language-server", args = ["--stdio"], root_globs = [".git"] }'
  set buffer lsp_language_id "csharp"
}
