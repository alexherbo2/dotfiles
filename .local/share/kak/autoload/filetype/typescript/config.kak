# This script provides support for the TypeScript programming language.
# https://typescriptlang.org

hook global BufCreate '.+\.ts' %{
  set-option buffer filetype typescript
}

hook global BufSetOption filetype=typescript %{
  add-highlighter buffer/typescript ref javascript
  set-option buffer increase_indent_pattern %opt{javascript_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{javascript_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{javascript_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{javascript_line_comment_token}
  set-option buffer block_comment_tokens %opt{javascript_block_comment_tokens}
  set-option buffer static_words %opt{javascript_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!typescript).*' %{
    remove-highlighter buffer/typescript
  }
}
