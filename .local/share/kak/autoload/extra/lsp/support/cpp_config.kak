hook global BufSetOption "filetype=cpp" %{
  set buffer lsp_servers 'clangd = { command = "clangd", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "cpp"
}
