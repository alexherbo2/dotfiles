hook global BufSetOption "filetype=cpp" %{
  set buffer lsp_servers 'clangd = { command = "clangd", args = [] }'
  set buffer lsp_language_id "cpp"
}
