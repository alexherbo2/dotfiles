# Creates the base regions
add-highlighter shared/html regions
add-highlighter shared/html/code default-region group

# Comments
add-highlighter shared/html.comment regions
add-highlighter shared/html.comment/comment default-region group
add-highlighter shared/html.comment/comment/ fill comment

# Tags
add-highlighter shared/html.tag regions
add-highlighter shared/html.tag/tag default-region group
add-highlighter shared/html.tag/tag/attribute_name regex '[\w-]+' 0:attribute
add-highlighter shared/html.tag/tag/tag_name regex '<\K/?[\w-]+' 0:keyword

# Strings
add-highlighter shared/html.string regions
add-highlighter shared/html.string/string default-region group
add-highlighter shared/html.string/string/ fill string

# Operators
add-highlighter shared/html/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator
add-highlighter shared/html.tag/tag/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Tags
add-highlighter shared/html/tag region '<' '>' ref html.tag

# Comments
add-highlighter shared/html/comment region '<!--' '-->' ref html.comment

# Single quoted strings
add-highlighter shared/html.tag/string.quoted.single region "'" "'" ref html.string

# Double quoted strings
add-highlighter shared/html.tag/string.quoted.double region '"' '"' ref html.string
