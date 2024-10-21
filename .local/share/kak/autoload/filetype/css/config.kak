# This script provides support for the CSS style sheet language.
# https://developer.mozilla.org/en-US/docs/Web/HTML
# https://developer.mozilla.org/en-US/docs/Web/CSS
# https://developer.mozilla.org/en-US/docs/Web/CSS/Reference
# https://developer.mozilla.org/en-US/docs/Web/JavaScript
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
# https://developer.mozilla.org/en-US/docs/Web/HTML/Reference

hook global BufCreate '.+\.css' %{
  set-option buffer filetype css
}

hook global BufSetOption filetype=css %{
  add-highlighter buffer/css ref css
  set-option buffer increase_indent_pattern %opt{css_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{css_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{css_ignore_indent_pattern}
  set-option buffer line_comment_token
  set-option buffer block_comment_tokens %opt{css_block_comment_tokens}
  hook -always -once buffer BufSetOption 'filetype=(?!css).*' %{
    remove-highlighter buffer/css
  }
}
