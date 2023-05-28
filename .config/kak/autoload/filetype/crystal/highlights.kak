# Creates the base regions
add-highlighter shared/crystal regions
add-highlighter shared/crystal/code default-region group

# Comments
add-highlighter shared/crystal.comment regions
add-highlighter shared/crystal.comment/comment default-region group
add-highlighter shared/crystal.comment/comment/ fill comment

# Escape sequences
add-highlighter shared/crystal.escape_sequence regions
add-highlighter shared/crystal.escape_sequence/escape_sequence default-region group
add-highlighter shared/crystal.escape_sequence/escape_sequence/ fill string
add-highlighter shared/crystal.escape_sequence/escape_sequence/ regex '\\[abefnrtv]|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:value

# Strings
add-highlighter shared/crystal.string regions
add-highlighter shared/crystal.string/string default-region group
add-highlighter shared/crystal.string/string/ fill string
add-highlighter shared/crystal.string/string/ ref crystal.escape_sequence

# Interpolated strings
add-highlighter shared/crystal.string.interpolated regions
add-highlighter shared/crystal.string.interpolated/string default-region group
add-highlighter shared/crystal.string.interpolated/string/ fill string
add-highlighter shared/crystal.string.interpolated/string/ ref crystal.escape_sequence
add-highlighter shared/crystal.string.interpolated/ region -recurse '\{' '\$\{\K' '(?=\})' ref crystal

# Regular expressions
add-highlighter shared/crystal.regexp regions
add-highlighter shared/crystal.regexp/regexp default-region group
add-highlighter shared/crystal.regexp/regexp/ fill meta

# Syntax and semantics
add-highlighter shared/crystal/code/function_name_declaration regex '\bfunction\h+\K(?:\w+\.)*(?:\w+:)?\w+(?=\()' 0:function
add-highlighter shared/crystal/code/function_name_call regex '\b(?:\w+\.)*(?:\w+:)?\w+(?=[\(\{\[])' 0:function

# Keywords
add-highlighter shared/crystal/code/keyword regex '\binstanceof\b|\bfunction\b|\bdebugger\b|\bcontinue\b|\bfinally\b|\bextends\b|\bdefault\b|\btypeof\b|\bswitch\b|\bimport\b|\bexport\b|\bdelete\b|\bwhile\b|\bthrow\b|\bsuper\b|\bconst\b|\bclass\b|\bcatch\b|\bbreak\b|\bwith\b|\bvoid\b|\belse\b|\bcase\b|\bvar\b|\btry\b|\bnew\b|\bfor\b|\bin\b|\bif\b|\bdo\b|\bstatic\b|\byield\b|\bawait\b|\blet\b|\basync\b|\breturn\b' 0:keyword

# Operators
add-highlighter shared/crystal/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Literals
add-highlighter shared/crystal/code/literal regex '\bthis\b|\bundefined\b|\bdocument\b|\bwindow\b|\bfalse\b|\btrue\b|\bnull\b|\b_G\b|\b_ENV\b|\d[\d_]*\.\w[\w]*|\d[\w]*|\b[A-Z]\w*\b' 0:value

# Comments
add-highlighter shared/crystal/comment region '//' '$' ref crystal.comment

# Single quoted strings
add-highlighter shared/crystal/string.quoted.single region "'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/crystal/string.quoted.single/escaping ref crystal.string
add-highlighter shared/crystal/string.quoted.single/escaped regex "\\'" 0:value

# Double quoted strings
add-highlighter shared/crystal/string.quoted.double region '"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/crystal/string.quoted.double/escaping ref crystal.string
add-highlighter shared/crystal/string.quoted.double/escaped regex '\\"' 0:value

# Template strings
add-highlighter shared/crystal/string.quoted.template region '`' '(?<!\\)(?:\\\\)*`' group
add-highlighter shared/crystal/string.quoted.template/interpolated ref crystal.string.interpolated
add-highlighter shared/crystal/string.quoted.template/escaped regex '\\`' 0:value

# Regular expressions
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
add-highlighter shared/crystal/string.quoted.regexp region '/\H' '(?<!\\)(?:\\\\)*/[imsdguy]*' group
add-highlighter shared/crystal/string.quoted.regexp/regexp ref crystal.regexp
add-highlighter shared/crystal/string.quoted.regexp/escaped regex '\\/' 0:value
