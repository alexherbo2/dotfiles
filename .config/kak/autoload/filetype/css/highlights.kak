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
add-highlighter shared/css.tag/string.quoted.single region "'" "'" ref css.string

# Double quoted strings
add-highlighter shared/css.tag/string.quoted.double region '"' '"' ref css.string
