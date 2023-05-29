# Creates the base regions
add-highlighter shared/markdown regions
add-highlighter shared/markdown/text default-region group

# Link text
add-highlighter shared/markdown.link regions
add-highlighter shared/markdown.link/link default-region group
add-highlighter shared/markdown.link/link/ fill link

# Code blocks
add-highlighter shared/markdown.code regions
add-highlighter shared/markdown.code/code default-region group
add-highlighter shared/markdown.code/code/ fill mono

add-highlighter shared/markdown/text/header regex '(?S)^#{1,6}\h+.+$' 0:header
add-highlighter shared/markdown/link region -recurse '\[' '\[\K' '(?=\])' ref markdown.link
add-highlighter shared/markdown/code region -match-capture '(`{1,3})' '(`{1,3})' ref markdown.code

# Operators
add-highlighter shared/markdown/text/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator
