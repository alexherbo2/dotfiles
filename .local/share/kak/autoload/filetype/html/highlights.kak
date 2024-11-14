add-highlighter shared/html regions

add-highlighter shared/html/ region '<!--' '-->' fill comment

add-highlighter shared/html/tag region '<' '>' regions
add-highlighter shared/html/tag/tag default-region group
add-highlighter shared/html/tag/tag/ regex '<\K/?[\w-]+' 0:keyword
add-highlighter shared/html/tag/tag/ regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator
add-highlighter shared/html/tag/tag/ regex '([\w-]+)=' 1:attribute
add-highlighter shared/html/tag/ region "[\w-]+=\K'" "'" ref html.string
add-highlighter shared/html/tag/ region '[\w-]+=\K"' '"' ref html.string

add-highlighter shared/html/ region '<style\b.*?>\K' '(?=</style>)' ref css
add-highlighter shared/html/ region '<script\b.*?>\K' '(?=</script>)' ref javascript

add-highlighter shared/html.string regions
add-highlighter shared/html.string/string default-region group
add-highlighter shared/html.string/string/ fill string
add-highlighter shared/html.string/string/ regex '&([0-9A-Za-z]+);|&#(\d+);|&#[xX]([0-9A-Fa-f]+);' 0:constant
