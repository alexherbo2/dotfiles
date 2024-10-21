# This script provides support for the YAML file format.
# https://yaml.org

hook global BufCreate '.+\.yml|.+\.yaml' %{
  set-option buffer filetype yaml
}

hook global BufSetOption filetype=yaml %{
  add-highlighter buffer/yaml ref yaml
  set-option buffer increase_indent_pattern %opt{yaml_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{yaml_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{yaml_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{yaml_line_comment_token}
  hook -always -once buffer BufSetOption 'filetype=(?!yaml).*' %{
    remove-highlighter buffer/yaml
  }
}
