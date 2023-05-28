# Creates the base regions
add-highlighter shared/toml regions
add-highlighter shared/toml/code default-region group
###
# https://github.com/toml-lang/toml/tree/v0.4.0
add-highlighter shared/toml/comment2 region '#'   $           fill comment
add-highlighter shared/toml/string1 region  '"""' (?<!\\)(\\\\)*"""(?!") fill string
add-highlighter shared/toml/string2 region  "'''" "'''(?!')"             fill string
add-highlighter shared/toml/string3 region  '"'   (?<!\\)(\\\\)*"        fill string
add-highlighter shared/toml/string4 region  "'"   "'"                    fill string
add-highlighter shared/toml/code/ regex "^\h*\[\[?([A-Za-z0-9._-]*)\]\]?" 1:title
add-highlighter shared/toml/code/ regex (?<!\w)[+-]?[0-9](_?\d)*(\.[0-9](_?\d)*)?([eE][+-]?[0-9](_?\d)*)?\b 0:value
add-highlighter shared/toml/code/ regex true|false 0:value
add-highlighter shared/toml/code/ regex '\d{4}-\d{2}-\d{2}[Tt ]\d{2}:\d{2}:\d{2}(.\d+)?([Zz]|[+-]\d{2}:\d{2})' 0:value
###
# Comments
add-highlighter shared/toml.comment regions
add-highlighter shared/toml.comment/comment default-region group
add-highlighter shared/toml.comment/comment/ fill comment

# Escape sequences
add-highlighter shared/toml.escape_sequence regions
add-highlighter shared/toml.escape_sequence/escape_sequence default-region group
add-highlighter shared/toml.escape_sequence/escape_sequence/ fill string
add-highlighter shared/toml.escape_sequence/escape_sequence/ regex '\\[abefnrtv]|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:value

# Strings
add-highlighter shared/toml.string regions
add-highlighter shared/toml.string/string default-region group
add-highlighter shared/toml.string/string/ fill string
add-highlighter shared/toml.string/string/ ref toml.escape_sequence

# Interpolated strings
add-highlighter shared/toml.string.interpolated regions
add-highlighter shared/toml.string.interpolated/string default-region group
add-highlighter shared/toml.string.interpolated/string/ fill string
add-highlighter shared/toml.string.interpolated/string/ ref toml.escape_sequence
add-highlighter shared/toml.string.interpolated/ region -recurse '\{' '\$\{\K' '(?=\})' ref toml

# Regular expressions
add-highlighter shared/toml.regexp regions
add-highlighter shared/toml.regexp/regexp default-region group
add-highlighter shared/toml.regexp/regexp/ fill meta

# Syntax and semantics
add-highlighter shared/toml/code/function_name_declaration regex '\bfunction\h+\K(?:\w+\.)*(?:\w+:)?\w+(?=\()' 0:function
add-highlighter shared/toml/code/function_name_call regex '\b(?:\w+\.)*(?:\w+:)?\w+(?=[\(\{\[])' 0:function

# Keywords
add-highlighter shared/toml/code/keyword regex '\binstanceof\b|\bfunction\b|\bdebugger\b|\bcontinue\b|\bfinally\b|\bextends\b|\bdefault\b|\btypeof\b|\bswitch\b|\bimport\b|\bexport\b|\bdelete\b|\bwhile\b|\bthrow\b|\bsuper\b|\bconst\b|\bclass\b|\bcatch\b|\bbreak\b|\bwith\b|\bvoid\b|\belse\b|\bcase\b|\bvar\b|\btry\b|\bnew\b|\bfor\b|\bin\b|\bif\b|\bdo\b|\bstatic\b|\byield\b|\bawait\b|\blet\b|\basync\b|\breturn\b' 0:keyword

# Operators
add-highlighter shared/toml/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Literals
add-highlighter shared/toml/code/literal regex '\bthis\b|\bundefined\b|\bdocument\b|\bwindow\b|\bfalse\b|\btrue\b|\bnull\b|\b_G\b|\b_ENV\b|\d[\d_]*\.\w[\w]*|\d[\w]*|\b[A-Z]\w*\b' 0:value

# Comments
add-highlighter shared/toml/comment region '//' '$' ref toml.comment

# Single quoted strings
add-highlighter shared/toml/string.quoted.single region "'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/toml/string.quoted.single/escaping ref toml.string
add-highlighter shared/toml/string.quoted.single/escaped regex "\\'" 0:value

# Double quoted strings
add-highlighter shared/toml/string.quoted.double region '"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/toml/string.quoted.double/escaping ref toml.string
add-highlighter shared/toml/string.quoted.double/escaped regex '\\"' 0:value

# Template strings
add-highlighter shared/toml/string.quoted.template region '`' '(?<!\\)(?:\\\\)*`' group
add-highlighter shared/toml/string.quoted.template/interpolated ref toml.string.interpolated
add-highlighter shared/toml/string.quoted.template/escaped regex '\\`' 0:value

# Regular expressions
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
add-highlighter shared/toml/string.quoted.regexp region '/\H' '(?<!\\)(?:\\\\)*/[imsdguy]*' group
add-highlighter shared/toml/string.quoted.regexp/regexp ref toml.regexp
add-highlighter shared/toml/string.quoted.regexp/escaped regex '\\/' 0:value
