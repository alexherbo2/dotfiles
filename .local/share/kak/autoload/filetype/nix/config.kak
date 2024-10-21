# This script provides support for the Lua programming language.
# https://nix.org/manual/5.4/manual.html

hook global BufCreate '.+\.nix' %{
  set-option buffer filetype nix
}

hook global BufSetOption filetype=nix %{
  add-highlighter buffer/nix ref nix
  set-option buffer increase_indent_pattern %opt{nix_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{nix_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{nix_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{nix_line_comment_token}
  set-option buffer block_comment_tokens %opt{nix_block_comment_tokens}
  set-option buffer static_words %opt{nix_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!nix).*' %{
    remove-highlighter buffer/nix
  }
}
