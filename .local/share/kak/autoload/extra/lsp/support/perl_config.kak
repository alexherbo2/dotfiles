hook global BufSetOption "filetype=perl" %{
  set buffer lsp_servers 'perlnavigator = { command = "perlnavigator", args = ["--stdio"], root_globs = [".git"] }'
  set buffer lsp_language_id "perl"
}
