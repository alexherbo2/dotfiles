# This script provides support for the HTML markup language.
# https://developer.mozilla.org/en-US/docs/Web/HTML
# https://developer.mozilla.org/en-US/docs/Web/CSS
# https://developer.mozilla.org/en-US/docs/Web/CSS/Reference
# https://developer.mozilla.org/en-US/docs/Web/JavaScript
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
# https://developer.mozilla.org/en-US/docs/Web/HTML/Reference

hook global BufCreate '.+\.html' %{
  set-option buffer filetype html
}

hook global BufSetOption filetype=html %{
  add-highlighter buffer/html ref html
  set-option buffer increase_indent_pattern %opt{html_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{html_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{html_ignore_indent_pattern}
  set-option buffer line_comment_token
  set-option buffer block_comment_tokens %opt{html_block_comment_tokens}
  hook -always -once buffer BufSetOption 'filetype=(?!html).*' %{
    remove-highlighter buffer/html
  }
}
