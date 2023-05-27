# This script provides support for the Lua programming language.
# https://lua.org/manual/5.4/manual.html

hook global BufCreate '.+\.lua' %{
  set-option buffer filetype lua
}

hook global BufSetOption filetype=lua %{
  add-highlighter buffer/lua ref lua
  set-option buffer increase_indent_pattern '[({\[]$|\b(do|else|repeat|then)$|\bfunction\h*\(.*?\)$|\bfunction\h+(?:\w+\.)*(?:\w+:)?\w+\(.*?\)$'
  set-option buffer decrease_indent_pattern '^\h*[)}\]]$|^\h*(else|end|until)$'
  set-option buffer ignore_indent_pattern '^\h*--'
  set-option buffer line_comment_token '--'
  set-option buffer block_comment_tokens '[[--' '--]]'
  set-option buffer static_words 'and' 'break' 'do' 'else' 'elseif' 'end' 'false' 'for' 'function' 'goto' 'if' 'in' 'local' 'nil' 'not' 'or' 'repeat' 'return' 'then' 'true' 'until' 'while'
  hook -always -once buffer BufSetOption 'filetype=(?!lua).*' %{
    remove-highlighter buffer/lua
  }
}
