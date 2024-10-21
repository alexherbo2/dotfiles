# Creates the base regions
add-highlighter shared/nix regions
add-highlighter shared/nix/code default-region group

# Comments
add-highlighter shared/nix.comment regions
add-highlighter shared/nix.comment/comment default-region group
add-highlighter shared/nix.comment/comment/ fill comment

# Strings
# Raw strings
add-highlighter shared/nix.string fill string

# String with escape sequences
add-highlighter shared/nix.string.escaping regions
add-highlighter shared/nix.string.escaping/string default-region group
add-highlighter shared/nix.string.escaping/string/ fill string
add-highlighter shared/nix.string.escaping/string/ regex '\\[abefnrtv]|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:value

# Syntax and semantics
add-highlighter shared/nix/code/function_name_declaration regex '\bfunction\h+\K(?:\w+\.)*(?:\w+:)?\w+(?=\()' 0:function
add-highlighter shared/nix/code/function_name_call regex '\b(?:\w+\.)*(?:\w+:)?\w+(?=[\(\{\[])' 0:function

# Keywords
add-highlighter shared/nix/code/keyword regex '\bfunction\b|\breturn\b|\brepeat\b|\belseif\b|\bwhile\b|\buntil\b|\blocal\b|\bfalse\b|\bbreak\b|\btrue\b|\bthen\b|\bgoto\b|\belse\b|\bnot\b|\bnil\b|\bfor\b|\bend\b|\band\b|\bor\b|\bin\b|\bif\b|\bdo\b' 0:keyword

# Operators
add-highlighter shared/nix/code/operator regex '[-+*/%^#&~|<>=:(){}[\];:,.]' 0:operator

# Literals
add-highlighter shared/nix/code/literal regex '\bfalse\b|\btrue\b|\bnil\b|\b_G\b|\b_ENV\b|\d[\d_]*\.\w[\w]*|\d[\w]*|\b[A-Z]\w*\b' 0:value

# Comments
add-highlighter shared/nix/comment region '(^|\h)\K#' '$' ref nix.comment

# Single quoted strings
add-highlighter shared/nix/string.quoted.single region "'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/nix/string.quoted.single/escaping ref nix.string.escaping
add-highlighter shared/nix/string.quoted.single/escaped regex "\\'" 0:value

# Double quoted strings
add-highlighter shared/nix/string.quoted.double region '"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/nix/string.quoted.double/escaping ref nix.string.escaping
add-highlighter shared/nix/string.quoted.double/escaped regex '\\"' 0:value

add-highlighter shared/nix/string.quoted.bracket region -match-capture '\[(=*)\[' '\](=*)\]' ref nix.string
add-highlighter shared/nix/comment.quoted.bracket region -match-capture '--\[(=*)\[' '\](=*)\]' ref nix.comment
