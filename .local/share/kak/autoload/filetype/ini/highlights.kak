# INI
# https://ini.org

# Creates the base regions
add-highlighter shared/ini regions
add-highlighter shared/ini/code default-region group
add-highlighter shared/ini/code/key regex '(?S)^\h*([\w-]+)\h*=\h*(.+)\h*$' 1:variable 2:value
add-highlighter shared/ini/code/section regex '(?S)^\h*\[.*\]\h*$' 0:title
add-highlighter shared/ini/comment region '[;#]' '$' group
add-highlighter shared/ini/comment/fill fill comment
