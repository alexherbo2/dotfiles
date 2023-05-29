# Creates the base regions
add-highlighter shared/css regions
add-highlighter shared/css/code default-region group

# Comments
add-highlighter shared/css.comment regions
add-highlighter shared/css.comment/comment default-region group
add-highlighter shared/css.comment/comment/ fill comment

# Strings
add-highlighter shared/css.string regions
add-highlighter shared/css.string/string default-region group
add-highlighter shared/css.string/string/ fill string

# Operators
add-highlighter shared/css/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Comments
add-highlighter shared/css/comment region '/\*' '\*/' ref css.comment

# Single quoted strings
add-highlighter shared/css/string.quoted.single region "(?<!\\)(?:\\\\)*\K'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/css/string.quoted.single/escaped regex "\\'" 0:value
add-highlighter shared/css/string.quoted.single/ ref css.string

# Double quoted strings
add-highlighter shared/css/string.quoted.double region '(?<!\\)(?:\\\\)*\K"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/css/string.quoted.double/escaped regex '\\"' 0:value
add-highlighter shared/css/string.quoted.double/ ref css.string
