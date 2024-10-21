# This script provides support for the Markdown markup language.
# https://developer.mozilla.org/en-US/docs/Web/HTML
# https://developer.mozilla.org/en-US/docs/Web/CSS
# https://developer.mozilla.org/en-US/docs/Web/CSS/Reference
# https://developer.mozilla.org/en-US/docs/Web/JavaScript
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
# https://developer.mozilla.org/en-US/docs/Web/HTML/Reference
# https://commonmark.org/help/tutorial/

hook global BufCreate '.+\.md|.+\.markdown' %{
  set-option buffer filetype markdown
}

hook global BufSetOption filetype=markdown %{
  add-highlighter buffer/markdown ref markdown
  set-option buffer increase_indent_pattern %opt{markdown_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{markdown_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{markdown_ignore_indent_pattern}
  hook -always -once buffer BufSetOption 'filetype=(?!markdown).*' %{
    remove-highlighter buffer/markdown
  }
}
