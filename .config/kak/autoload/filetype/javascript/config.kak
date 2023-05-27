# This script provides support for the JavaScript programming language.
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar

hook global BufCreate '.+\.js' %{
  set-option buffer filetype javascript
}

hook global BufSetOption filetype=javascript %{
  add-highlighter buffer/javascript ref javascript
  set-option buffer increase_indent_pattern '[({\[]$'
  set-option buffer decrease_indent_pattern '^\h*[)}\]]$'
  set-option buffer ignore_indent_pattern '^\h*//'
  set-option buffer line_comment_token '//'
  set-option buffer block_comment_tokens '/*' '*/'
  set-option buffer static_words 'break' 'case' 'catch' 'class' 'const' 'continue' 'debugger' 'default' 'delete' 'do' 'else' 'export' 'extends' 'false' 'finally' 'for' 'function' 'if' 'import' 'in' 'instanceof' 'new' 'null' 'super' 'switch' 'this' 'throw' 'true' 'try' 'typeof' 'var' 'void' 'while' 'with' 'let' 'static' 'yield' 'await' 'async' 'return' 'undefined' 'document' 'window'
  hook -always -once buffer BufSetOption 'filetype=(?!javascript).*' %{
    remove-highlighter buffer/javascript
  }
}
