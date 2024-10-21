# This script provides support for Kakoune syntax and semantics.
# https://kakoune.org

hook global BufCreate '.+/kakrc|.+\.kak' %{
  set-option buffer filetype kakrc
}

hook global BufSetOption filetype=kakrc %{
  add-highlighter buffer/kakrc ref kakrc
  set-option buffer increase_indent_pattern %opt{kakrc_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{kakrc_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{kakrc_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{kakrc_line_comment_token}
  set-option buffer extra_word_chars %opt{kakrc_extra_word_chars}
  set-option buffer static_words %opt{kakrc_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!kakrc).*' %{
    remove-highlighter buffer/kakrc
  }
}
