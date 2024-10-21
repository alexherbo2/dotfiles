# This script provides support for the JavaScript programming language.
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar

hook global BufCreate '.+\.js' %{
  set-option buffer filetype javascript
}

hook global BufSetOption filetype=javascript %{
  add-highlighter buffer/javascript ref javascript
  set-option buffer increase_indent_pattern %opt{javascript_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{javascript_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{javascript_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{javascript_line_comment_token}
  set-option buffer block_comment_tokens %opt{javascript_block_comment_tokens}
  set-option buffer static_words %opt{javascript_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!javascript).*' %{
    remove-highlighter buffer/javascript
  }
}
