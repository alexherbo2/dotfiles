# Creates the base regions
add-highlighter shared/toml regions
add-highlighter shared/toml/code default-region group

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

# Interpolated strings
add-highlighter shared/toml.string.interpolated regions
add-highlighter shared/toml.string.interpolated/string default-region group
add-highlighter shared/toml.string.interpolated/string/ fill string
add-highlighter shared/toml.string.interpolated/string/ ref toml.escape_sequence

# Regular expressions
add-highlighter shared/toml.regexp regions
add-highlighter shared/toml.regexp/regexp default-region group
add-highlighter shared/toml.regexp/regexp/ fill meta

add-highlighter shared/toml/code/key regex '(?S)^\h*([\w-]+)\h*=\h*(.+)\h*$' 1:variable 2:value
add-highlighter shared/toml/code/section regex '(?S)^\h*\[.*\]\h*$' 0:title

# Operators
add-highlighter shared/toml/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Literals
add-highlighter shared/toml/code/literal regex '\bfalse\b|\btrue\b' 0:value
add-highlighter shared/toml/code/date_time regex '\d{4}-\d{2}-\d{2}[Tt]\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:[Zz]|[+-]\d{2}:\d{2})?' 0:value
add-highlighter shared/toml/code/date regex '\d{4}-\d{2}-\d{2}' 0:value
add-highlighter shared/toml/code/time regex '\d{2}:\d{2}:\d{2}(?:\.\d+)?' 0:value
add-highlighter shared/toml/code/constant.numeric.integer.decimal regex '\b[+-]?\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/toml/code/constant.numeric.float.decimal regex '\b[+-]?\d(_?\d+)*\.\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_(f32|f64))?\b' 0:value
add-highlighter shared/toml/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/toml/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/toml/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments
add-highlighter shared/toml/comment region '#' '$' ref toml.comment

# Single quoted strings
add-highlighter shared/toml/string.quoted.single region "'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/toml/string.quoted.single/ ref toml.string

# Triple Single quoted strings
add-highlighter shared/toml/string.quoted.triple.single region "'''" "'''(?!')" group
add-highlighter shared/toml/string.quoted.triple.single/ ref toml.string

# Double quoted strings
add-highlighter shared/toml/string.quoted.double region '"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/toml/string.quoted.double/ ref toml.string.interpolated
add-highlighter shared/toml/string.quoted.double/escaped regex '\\"' 0:value

# Triple Double quoted strings
add-highlighter shared/toml/string.quoted.triple.double region '"""' '(?<!\\)(?:\\\\)*"""(?!")' group
add-highlighter shared/toml/string.quoted.triple.double/ ref toml.string.interpolated
add-highlighter shared/toml/string.quoted.triple.double/escaped regex '\\"' 0:value
