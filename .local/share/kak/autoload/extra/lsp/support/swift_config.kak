hook global BufSetOption "filetype=swift" %{
  set buffer lsp_servers 'sourcekit-lsp = { command = "sourcekit-lsp", args = [], root_globs = ["Package.swift", ".git"] }'
  set buffer lsp_language_id "swift"
}
