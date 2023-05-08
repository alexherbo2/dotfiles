# This script provides support for the JavaScript programming language.
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar

hook global BufCreate '.+\.js' %{
  set-option buffer filetype javascript
}

hook global BufSetOption filetype=javascript %{
  add-highlighter buffer/javascript ref javascript
  set-option buffer increase_indent_pattern '[({\[]$|\b(do|else|repeat|then)$|\bfunction\h*\(.*?\)$|\bfunction\h+(?:\w+\.)*(?:\w+:)?\w+\(.*?\)$'
  set-option buffer decrease_indent_pattern '^\h*[)}\]]$|^\h*(else|end|until)$'
  set-option buffer ignore_indent_pattern '^\h*//'
  set-option buffer line_comment_token '//'
  set-option buffer block_comment_tokens '/*' '*/'
  set-option buffer static_words 'break' 'case' 'catch' 'class' 'const' 'continue' 'debugger' 'default' 'delete' 'do' 'else' 'export' 'extends' 'false' 'finally' 'for' 'function' 'if' 'import' 'in' 'instanceof' 'new' 'null' 'super' 'switch' 'this' 'throw' 'true' 'try' 'typeof' 'var' 'void' 'while' 'with' 'let' 'static' 'yield' 'await' 'async' 'return' 'undefined' 'document' 'window'
  hook -always -once buffer BufSetOption 'filetype=(?!javascript).*' %{
    remove-highlighter buffer/javascript
  }
}

# Creates the base regions
add-highlighter shared/javascript regions
add-highlighter shared/javascript/code default-region group

# Comments
add-highlighter shared/javascript.comment regions
add-highlighter shared/javascript.comment/comment default-region group
add-highlighter shared/javascript.comment/comment/ fill comment

# Escape sequences
add-highlighter shared/javascript.escape_sequence regions
add-highlighter shared/javascript.escape_sequence/escape_sequence default-region group
add-highlighter shared/javascript.escape_sequence/escape_sequence/ fill string
add-highlighter shared/javascript.escape_sequence/escape_sequence/ regex '\\[abefnrtv]|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:value

# Strings
add-highlighter shared/javascript.string regions
add-highlighter shared/javascript.string/string default-region group
add-highlighter shared/javascript.string/string/ fill string
add-highlighter shared/javascript.string/string/ ref javascript.escape_sequence

# Interpolated strings
add-highlighter shared/javascript.string.interpolated regions
add-highlighter shared/javascript.string.interpolated/string default-region group
add-highlighter shared/javascript.string.interpolated/string/ fill string
add-highlighter shared/javascript.string.interpolated/string/ ref javascript.escape_sequence
add-highlighter shared/javascript.string.interpolated/ region -recurse '\{' '\$\{\K' '(?=\})' ref javascript

# Regular expressions
add-highlighter shared/javascript.regexp regions
add-highlighter shared/javascript.regexp/regexp default-region group
add-highlighter shared/javascript.regexp/regexp/ fill meta

# Syntax and semantics
add-highlighter shared/javascript/code/function_name_declaration regex '\bfunction\h+\K(?:\w+\.)*(?:\w+:)?\w+(?=\()' 0:function
add-highlighter shared/javascript/code/function_name_call regex '\b(?:\w+\.)*(?:\w+:)?\w+(?=[\(\{\[])' 0:function

# Keywords
add-highlighter shared/javascript/code/keyword regex '\binstanceof\b|\bfunction\b|\bdebugger\b|\bcontinue\b|\bfinally\b|\bextends\b|\bdefault\b|\btypeof\b|\bswitch\b|\bimport\b|\bexport\b|\bdelete\b|\bwhile\b|\bthrow\b|\bsuper\b|\bconst\b|\bclass\b|\bcatch\b|\bbreak\b|\bwith\b|\bvoid\b|\belse\b|\bcase\b|\bvar\b|\btry\b|\bnew\b|\bfor\b|\bin\b|\bif\b|\bdo\b|\bstatic\b|\byield\b|\bawait\b|\blet\b|\basync\b|\breturn\b' 0:keyword

# Operators
add-highlighter shared/javascript/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Literals
add-highlighter shared/javascript/code/literal regex '\bthis\b|\bundefined\b|\bdocument\b|\bwindow\b|\bfalse\b|\btrue\b|\bnull\b|\b_G\b|\b_ENV\b|\d[\d_]*\.\w[\w]*|\d[\w]*|\b[A-Z]\w*\b' 0:value

# Comments
add-highlighter shared/javascript/comment region '//' '$' ref javascript.comment

# Single quoted strings
add-highlighter shared/javascript/string.quoted.single region "'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/javascript/string.quoted.single/escaping ref javascript.string
add-highlighter shared/javascript/string.quoted.single/escaped regex "\\'" 0:value

# Double quoted strings
add-highlighter shared/javascript/string.quoted.double region '"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/javascript/string.quoted.double/escaping ref javascript.string
add-highlighter shared/javascript/string.quoted.double/escaped regex '\\"' 0:value

# Template strings
add-highlighter shared/javascript/string.quoted.template region '`' '(?<!\\)(?:\\\\)*`' group
add-highlighter shared/javascript/string.quoted.template/interpolated ref javascript.string.interpolated
add-highlighter shared/javascript/string.quoted.template/escaped regex '\\`' 0:value

# Regular expressions
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
add-highlighter shared/javascript/string.quoted.regexp region '/\H' '(?<!\\)(?:\\\\)*/[imsdguy]*' group
add-highlighter shared/javascript/string.quoted.regexp/regexp ref javascript.regexp
add-highlighter shared/javascript/string.quoted.regexp/escaped regex '\\/' 0:value
