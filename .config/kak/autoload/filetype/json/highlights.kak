# Creates the base regions
add-highlighter shared/json regions
add-highlighter shared/json/code default-region group

# Comments
add-highlighter shared/json.comment regions
add-highlighter shared/json.comment/comment default-region group
add-highlighter shared/json.comment/comment/ fill comment

# Escape sequences
add-highlighter shared/json.escape_sequence regions
add-highlighter shared/json.escape_sequence/escape_sequence default-region group
add-highlighter shared/json.escape_sequence/escape_sequence/ fill string
add-highlighter shared/json.escape_sequence/escape_sequence/ regex '\\[abefnrtv]|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:value

# Strings
add-highlighter shared/json.string regions
add-highlighter shared/json.string/string default-region group
add-highlighter shared/json.string/string/ fill string
add-highlighter shared/json.string/string/ ref json.escape_sequence

# Interpolated strings
add-highlighter shared/json.string.interpolated regions
add-highlighter shared/json.string.interpolated/string default-region group
add-highlighter shared/json.string.interpolated/string/ fill string
add-highlighter shared/json.string.interpolated/string/ ref json.escape_sequence
add-highlighter shared/json.string.interpolated/ region -recurse '\{' '\$\{\K' '(?=\})' ref json

# Regular expressions
add-highlighter shared/json.regexp regions
add-highlighter shared/json.regexp/regexp default-region group
add-highlighter shared/json.regexp/regexp/ fill meta

# Syntax and semantics
add-highlighter shared/json/code/function_name_declaration regex '\bfunction\h+\K(?:\w+\.)*(?:\w+:)?\w+(?=\()' 0:function
add-highlighter shared/json/code/function_name_call regex '\b(?:\w+\.)*(?:\w+:)?\w+(?=[\(\{\[])' 0:function

# Keywords
add-highlighter shared/json/code/keyword regex '\binstanceof\b|\bfunction\b|\bdebugger\b|\bcontinue\b|\bfinally\b|\bextends\b|\bdefault\b|\btypeof\b|\bswitch\b|\bimport\b|\bexport\b|\bdelete\b|\bwhile\b|\bthrow\b|\bsuper\b|\bconst\b|\bclass\b|\bcatch\b|\bbreak\b|\bwith\b|\bvoid\b|\belse\b|\bcase\b|\bvar\b|\btry\b|\bnew\b|\bfor\b|\bin\b|\bif\b|\bdo\b|\bstatic\b|\byield\b|\bawait\b|\blet\b|\basync\b|\breturn\b' 0:keyword

# Operators
add-highlighter shared/json/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Literals
add-highlighter shared/json/code/literal regex '\bthis\b|\bundefined\b|\bdocument\b|\bwindow\b|\bfalse\b|\btrue\b|\bnull\b|\b_G\b|\b_ENV\b|\d[\d_]*\.\w[\w]*|\d[\w]*|\b[A-Z]\w*\b' 0:value

# Comments
add-highlighter shared/json/comment region '//' '$' ref json.comment

# Single quoted strings
add-highlighter shared/json/string.quoted.single region "'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/json/string.quoted.single/escaping ref json.string
add-highlighter shared/json/string.quoted.single/escaped regex "\\'" 0:value

# Double quoted strings
add-highlighter shared/json/string.quoted.double region '"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/json/string.quoted.double/escaping ref json.string
add-highlighter shared/json/string.quoted.double/escaped regex '\\"' 0:value

# Regular expressions
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
add-highlighter shared/json/string.quoted.regexp region '/\H' '(?<!\\)(?:\\\\)*/[imsdguy]*' group
add-highlighter shared/json/string.quoted.regexp/regexp ref json.regexp
add-highlighter shared/json/string.quoted.regexp/escaped regex '\\/' 0:value
