hook global BufSetOption "filetype=tsx" %{
  set buffer lsp_servers 'tsc = { command = "tsc", args = ["--lsp", "--stdio"], root_globs = [".git"] }'
  set buffer lsp_language_id "typescriptreact"
}
