# Creates the base regions
add-highlighter shared/css regions
add-highlighter shared/css/code default-region group

# Comments
add-highlighter shared/css.comment regions
add-highlighter shared/css.comment/comment default-region group
add-highlighter shared/css.comment/comment/ fill comment

# Attribute selectors
add-highlighter shared/css.attribute_selector regions
add-highlighter shared/css.attribute_selector/attribute_selector default-region group
add-highlighter shared/css.attribute_selector/string.quoted.single region "(?<!\\)(?:\\\\)*\K'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/css.attribute_selector/string.quoted.single/escaped regex "\\'" 0:value
add-highlighter shared/css.attribute_selector/string.quoted.single/ ref css.string
add-highlighter shared/css.attribute_selector/string.quoted.double region '(?<!\\)(?:\\\\)*\K"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/css.attribute_selector/string.quoted.double/escaped regex '\\"' 0:value
add-highlighter shared/css.attribute_selector/string.quoted.double/ ref css.string

# Properties
add-highlighter shared/css.properties regions
add-highlighter shared/css.properties/properties default-region group
add-highlighter shared/css.properties/string.quoted.single region "(?<!\\)(?:\\\\)*\K'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/css.properties/string.quoted.single/escaped regex "\\'" 0:value
add-highlighter shared/css.properties/string.quoted.single/ ref css.string
add-highlighter shared/css.properties/string.quoted.double region '(?<!\\)(?:\\\\)*\K"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/css.properties/string.quoted.double/escaped regex '\\"' 0:value
add-highlighter shared/css.properties/string.quoted.double/ ref css.string

##
add-highlighter shared/css.properties/properties/property_name regex '[\w-]+(?=:)' 0:variable
add-highlighter shared/css.properties/properties/function_name_call regex '\b(?:\w+\.)*(?:\w+:)?\w+(?=[\(\{\[])' 0:function
add-highlighter shared/css.properties/properties/string.special.color.hex_triplet regex '(?i)#[0-9a-f]{3,8}' 0:string

# https://developer.mozilla.org/en-US/docs/Web/CSS/Reference
# https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks
# https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Selectors
# https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Selectors/Attribute_selectors
# https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Values_and_units
# (cm|mm|Q|in|pc|pt|px|em|ex|ch|rem|lh|rlh|vw|vh|vmin|vmax|vb|vi|svw|svh|lvw|lvh|dvw|dvh)
add-highlighter shared/css.properties/properties/constant.numeric.integer.decimal regex '\b[+-]?\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(?:[a-zA-Z]+)?\b' 0:value
add-highlighter shared/css.properties/properties/constant.numeric.float.decimal regex '\b[+-]?\d(_?\d+)*\.\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(?:[a-zA-Z]+)?\b' 0:value
add-highlighter shared/css.properties/properties/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/css.properties/properties/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/css.properties/properties/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Strings
add-highlighter shared/css.string regions
add-highlighter shared/css.string/string default-region group
add-highlighter shared/css.string/string/ fill string

add-highlighter shared/css.attribute_selector/attribute_selector/tag_name regex '<\K/?[\w-]+' 0:keyword

# At rules
add-highlighter shared/css/code/at_rule regex '@[\w-]+' 0:keyword

# Operators
add-highlighter shared/css/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Attribute selectors
add-highlighter shared/css/attribute_selector region '\[\K' '(?=\])' ref css.attribute_selector

# Properties
add-highlighter shared/css/properties region '\{\K' '(?=\})' ref css.properties

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
