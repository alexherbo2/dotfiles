# This script provides support for the TSV file format.

# Sets TSV filetype when opening `.tsv` files.
hook global BufCreate '.+\.tsv' %{
  set-option buffer filetype tsv
}

# Enables syntax highlighting for TSV filetype.
hook global BufSetOption filetype=tsv %{
  add-highlighter buffer/tsv ref tsv
  hook -always -once buffer BufSetOption 'filetype=(?!tsv).*' %{
    remove-highlighter buffer/tsv
  }
}
