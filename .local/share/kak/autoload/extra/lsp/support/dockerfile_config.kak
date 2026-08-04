hook global BufSetOption "filetype=dockerfile" %{
  set buffer lsp_servers 'docker-language-server = { command = "docker-language-server", args = ["start", "--stdio"], root_globs = ["Dockerfile"] }'
  set buffer lsp_language_id "dockerfile"
}
