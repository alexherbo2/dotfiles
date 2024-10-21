# This script provides support for the CSV file format.
# https://datatracker.ietf.org/doc/html/rfc4180

# Sets CSV filetype when opening `.log` files.
hook global BufCreate '.+\.log' %{
  set-option buffer filetype log
}

# Enables syntax highlighting for CSV filetype.
hook global BufSetOption filetype=log %{
  add-highlighter buffer/log ref log
  hook -always -once buffer BufSetOption 'filetype=(?!log).*' %{
    remove-highlighter buffer/log
  }
}
