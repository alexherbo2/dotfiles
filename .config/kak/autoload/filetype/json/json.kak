# This script provides support for the JSON file format.
# https://json.org

hook global BufCreate '.+\.json' %{
  set-option buffer filetype json
}

hook global BufSetOption filetype=json %{
  add-highlighter buffer/json ref json
  set-option buffer increase_indent_pattern '[({\[]$'
  set-option buffer decrease_indent_pattern '^\h*[)}\]]$'
  set-option buffer ignore_indent_pattern '^\h*//'
  set-option buffer line_comment_token '//'
  set-option buffer block_comment_tokens '/*' '*/'
  hook -always -once buffer BufSetOption 'filetype=(?!json).*' %{
    remove-highlighter buffer/json
  }
}
