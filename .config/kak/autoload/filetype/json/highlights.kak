# Creates the base regions
add-highlighter shared/json regions
add-highlighter shared/json/code default-region group

# Strings
add-highlighter shared/json.string regions
add-highlighter shared/json.string/string default-region group
add-highlighter shared/json.string/string/ fill string

# Operators
add-highlighter shared/json/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Literals
add-highlighter shared/json/code/literal regex '\bfalse\b|\btrue\b|\bnull\b' 0:value

# Double quoted strings
add-highlighter shared/json/string.quoted.double region '"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/json/string.quoted.double/escaping ref json.string
add-highlighter shared/json/string.quoted.double/escaped regex '\\"' 0:value
