# This script provides support for the Lua programming language.
# https://lua.org/manual/5.4/manual.html

hook global BufCreate '.+\.lua' %{
  set-option buffer filetype lua
}

hook global BufSetOption filetype=lua %{
  add-highlighter buffer/lua ref lua
  set-option buffer increase_indent_pattern '[({\[]$|\b(do|else|then)$|\bfunction\h*\([^)]*?\)$|\bfunction\h+(?:\w+\.)*(?:\w+:)?\w+\([^)]*?\)$'
  set-option buffer decrease_indent_pattern '^\h*[)}\]]$|^\h*(else|end|until)$'
  set-option buffer ignore_indent_pattern '^\h*--'
  set-option buffer line_comment_token '--'
  set-option buffer block_comment_tokens '[[--' '--]]'
  set-option buffer static_words 'and' 'break' 'do' 'else' 'elseif' 'end' 'false' 'for' 'function' 'goto' 'if' 'in' 'local' 'nil' 'not' 'or' 'repeat' 'return' 'then' 'true' 'until' 'while'
  hook -always -once buffer BufSetOption 'filetype=(?!lua).*' %{
    remove-highlighter buffer/lua
  }
}

# Creates the base regions
add-highlighter shared/lua regions
add-highlighter shared/lua/code default-region group

# Comments
add-highlighter shared/lua.comment regions
add-highlighter shared/lua.comment/comment default-region group
add-highlighter shared/lua.comment/comment/ fill comment

# Strings
# Raw strings
add-highlighter shared/lua.string fill string

# String with escape sequences
add-highlighter shared/lua.string.escaping regions
add-highlighter shared/lua.string.escaping/string default-region group
add-highlighter shared/lua.string.escaping/string/ fill string
add-highlighter shared/lua.string.escaping/string/ regex '\\[abefnrtv]|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta

# Syntax and semantics
add-highlighter shared/lua/code/function_name_declaration regex '\bfunction\h+\K(?:\w+\.)*(?:\w+:)?\w+(?=\()' 0:function
add-highlighter shared/lua/code/function_name_call regex '\b(?:\w+\.)*(?:\w+:)?\w+(?=[\(\{\[])' 0:function

# Keywords
add-highlighter shared/lua/code/keyword regex '\bfunction\b|\breturn\b|\brepeat\b|\belseif\b|\bwhile\b|\buntil\b|\blocal\b|\bfalse\b|\bbreak\b|\btrue\b|\bthen\b|\bgoto\b|\belse\b|\bnot\b|\bnil\b|\bfor\b|\bend\b|\band\b|\bor\b|\bin\b|\bif\b|\bdo\b' 0:keyword

# Operators
add-highlighter shared/lua/code/operator regex '[-+*/%^#&~|<>=:(){}[\];:,.]' 0:operator

# Literals
add-highlighter shared/lua/code/literal regex '\bfalse\b|\btrue\b|\bnil\b|\b_G\b|\b_ENV\b|\d[\d_]*\.\w[\w]*|\d[\w]*' 0:value

# Types
add-highlighter shared/lua/code/type regex '\b[A-Z]\w*\b' 0:type

# Comments
add-highlighter shared/lua/comment region '--' '$' ref lua.comment

# Single quoted strings
add-highlighter shared/lua/string.quoted.single region "'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/lua/string.quoted.single/escaping ref lua.string.escaping
add-highlighter shared/lua/string.quoted.single/escaped regex "\\'" 0:meta

# Double quoted strings
add-highlighter shared/lua/string.quoted.double region '"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/lua/string.quoted.double/escaping ref lua.string.escaping
add-highlighter shared/lua/string.quoted.double/escaped regex '\\"' 0:meta

add-highlighter shared/lua/string.quoted.bracket region '\[\[\K' '(?=\]\])' ref lua.string
add-highlighter shared/lua/comment.quoted.bracket region '--\[\[\K' '(?=\]\])' ref lua.comment
