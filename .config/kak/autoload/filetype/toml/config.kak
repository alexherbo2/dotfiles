# This script provides support for the TOML file format.
# https://toml.io

hook global BufCreate '.+\.toml' %{
  set-option buffer filetype toml
}

hook global BufSetOption filetype=toml %{
  add-highlighter buffer/toml ref toml
  set-option buffer increase_indent_pattern %opt{toml_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{toml_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{toml_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{toml_line_comment_token}
  hook -always -once buffer BufSetOption 'filetype=(?!toml).*' %{
    remove-highlighter buffer/toml
  }
}
