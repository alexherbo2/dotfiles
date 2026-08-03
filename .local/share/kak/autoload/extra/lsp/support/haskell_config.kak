hook global BufSetOption "filetype=haskell" %{
  set buffer lsp_servers 'haskell-language-server = { command = "haskell-language-server-wrapper", args = ["--lsp"], root_globs = [".git"] }'
  set buffer lsp_language_id "haskell"
}
