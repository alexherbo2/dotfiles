# This script provides support for the CSV file format.
# https://datatracker.ietf.org/doc/html/rfc4180

# Sets CSV filetype when opening `.csv` files.
hook global BufCreate '.+\.csv' %{
  set-option buffer filetype csv
}

# Enables syntax highlighting for CSV filetype.
hook global BufSetOption filetype=csv %{
  add-highlighter buffer/csv ref csv
  hook -always -once buffer BufSetOption 'filetype=(?!csv).*' %{
    remove-highlighter buffer/csv
  }
}
