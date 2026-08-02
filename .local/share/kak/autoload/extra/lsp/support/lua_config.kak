hook global BufSetOption "filetype=lua" %{
  set buffer lsp_servers 'lua-language-server = { command = "lua-language-server", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "lua"
}
