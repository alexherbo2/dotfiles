hook global BufSetOption "filetype=ruby" %{
  set buffer lsp_servers 'solargraph = { command = "solargraph", args = ["stdio"], root_globs = ["Gemfile"] }'
  set buffer lsp_language_id "ruby"
}
