hook global BufCreate '.+\.[1-9]' %{
  set-option buffer filetype mdoc
}

hook global BufSetOption filetype=mdoc %{
  add-highlighter buffer/mdoc ref mdoc
  set-option buffer line_comment_token %opt{mdoc_line_comment_token}
  set-option buffer static_words %opt{mdoc_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!mdoc).*' %{
    remove-highlighter buffer/mdoc
  }
}
