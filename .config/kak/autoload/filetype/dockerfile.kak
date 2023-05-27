# Dockerfile
# https://docs.docker.com/engine/reference/builder/

hook global BufCreate '.+/Dockerfile' %{
  set-option buffer filetype dockerfile
}

hook global BufSetOption filetype=dockerfile %{
  add-highlighter buffer/dockerfile ref dockerfile
  set-option buffer line_comment_token %opt{dockerfile_line_comment_token}
  hook -always -once buffer BufSetOption 'filetype=(?!dockerfile).*' %{
    remove-highlighter buffer/dockerfile
  }
}
