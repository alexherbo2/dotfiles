# This script provides support for the INI file format.
# https://ini.org

hook global BufCreate '.+\.ini' %{
  set-option buffer filetype ini
}

hook global BufSetOption filetype=ini %{
  add-highlighter buffer/ini ref ini
  set-option buffer increase_indent_pattern %opt{ini_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{ini_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{ini_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{ini_line_comment_token}
  hook -always -once buffer BufSetOption 'filetype=(?!ini).*' %{
    remove-highlighter buffer/ini
  }
}
