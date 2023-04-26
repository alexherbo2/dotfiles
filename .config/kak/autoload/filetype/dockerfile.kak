# Dockerfile
# https://docs.docker.com/engine/reference/builder/

hook global BufCreate '.+/Dockerfile' %{
  set-option buffer filetype dockerfile
}

hook global WinSetOption filetype=dockerfile %{
  add-highlighter window/dockerfile ref dockerfile
  set-option window line_comment_token '#'
  hook -always -once window WinSetOption 'filetype=.*' %{
    remove-highlighter window/dockerfile
    unset-option window line_comment_token
  }
}

add-highlighter shared/dockerfile regions
add-highlighter shared/dockerfile/code default-region group
add-highlighter shared/dockerfile/code/instruction regex '^[A-Z ]+ ' 0:keyword
add-highlighter shared/dockerfile/comment region '^#' '$' fill comment
