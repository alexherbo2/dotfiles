hook global BufSetOption "filetype=java" %{
  set buffer lsp_servers 'jdtls = { command = "jdtls", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "java"
}
