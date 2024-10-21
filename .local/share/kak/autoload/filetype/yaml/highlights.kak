# Creates the base regions
add-highlighter shared/yaml regions
add-highlighter shared/yaml/code default-region group

# Comments
add-highlighter shared/yaml.comment regions
add-highlighter shared/yaml.comment/comment default-region group
add-highlighter shared/yaml.comment/comment/ fill comment

# Strings
add-highlighter shared/yaml.string regions
add-highlighter shared/yaml.string/string default-region group
add-highlighter shared/yaml.string/string/ fill string

# Attributes
add-highlighter shared/yaml/code/attribute regex '^\h*-?\h*\K[\w-]+(?=:)' 0:attribute

# Operators
add-highlighter shared/yaml/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Literals
add-highlighter shared/yaml/code/literal regex '\bfalse\b|\btrue\b|\bnull\b' 0:value

# Comments
add-highlighter shared/yaml/comment region '#' '$' ref yaml.comment

# Single quoted strings
add-highlighter shared/yaml/string.quoted.single region "'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/yaml/string.quoted.single/ ref yaml.string

# Double quoted strings
add-highlighter shared/yaml/string.quoted.double region '"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/yaml/string.quoted.double/escaping ref yaml.string
add-highlighter shared/yaml/string.quoted.double/escaped regex '\\"' 0:value
