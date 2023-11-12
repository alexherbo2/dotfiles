# Creates the base regions
add-highlighter shared/javascript regions
add-highlighter shared/javascript/code default-region group

# Comments
# https://jsdoc.app
# JSDoc reference
# https://typescriptlang.org/docs/handbook/jsdoc-supported-types.html
# WIP
add-highlighter shared/javascript.comment regions
add-highlighter shared/javascript.comment/comment default-region group
add-highlighter shared/javascript.comment/comment/ fill comment
add-highlighter shared/javascript.comment/comment/ regex '\B`[#.]?\w+[?!]?`\B|\B(?<!\*)\*\w+[?!]?\*(?!\*)\B' 0:meta
add-highlighter shared/javascript.comment/comment/ regex '\B(@(?:callback|enum|property|template|typedef|returns|param|type))(?:\h+(\{[^}]+\}+))?(?:\h+(\[[^\]]+\]\B|\S+\b))?' 1:keyword 2:type 3:variable
add-highlighter shared/javascript.comment/comment/ regex '\B(?:@\w+)\b' 0:keyword

# Escape sequences
add-highlighter shared/javascript.escape_sequence regions
add-highlighter shared/javascript.escape_sequence/escape_sequence default-region group
add-highlighter shared/javascript.escape_sequence/escape_sequence/ fill string
add-highlighter shared/javascript.escape_sequence/escape_sequence/ regex '\\[abefnrtv]|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:value

# Strings
add-highlighter shared/javascript.string regions
add-highlighter shared/javascript.string/string default-region group
add-highlighter shared/javascript.string/string/ fill string
add-highlighter shared/javascript.string/string/ ref javascript.escape_sequence

# Interpolated strings
add-highlighter shared/javascript.string.interpolated regions
add-highlighter shared/javascript.string.interpolated/string default-region group
add-highlighter shared/javascript.string.interpolated/string/ fill string
add-highlighter shared/javascript.string.interpolated/string/ ref javascript.escape_sequence
add-highlighter shared/javascript.string.interpolated/ region -recurse '\{' '\$\{\K' '(?=\})' ref javascript

# Regular expressions
add-highlighter shared/javascript.regexp regions
add-highlighter shared/javascript.regexp/regexp default-region group
add-highlighter shared/javascript.regexp/regexp/ fill meta

# Syntax and semantics
add-highlighter shared/javascript/code/function_name_declaration regex '\bfunction\h+\K(?:\w+\.)*(?:\w+:)?\w+(?=\()' 0:function
add-highlighter shared/javascript/code/function_name_call regex '\b(?:\w+\.)*(?:\w+:)?\w+(?=[\(\{\[])' 0:function

# Keywords
add-highlighter shared/javascript/code/keyword regex '\binstanceof\b|\bfunction\b|\bdebugger\b|\bcontinue\b|\bfinally\b|\bextends\b|\bdefault\b|\btypeof\b|\bswitch\b|\bimport\b|\bexport\b|\bdelete\b|\bwhile\b|\bthrow\b|\bsuper\b|\bconst\b|\bclass\b|\bcatch\b|\bbreak\b|\bwith\b|\bvoid\b|\belse\b|\bcase\b|\bvar\b|\btry\b|\bnew\b|\bfor\b|\bin\b|\bif\b|\bdo\b|\bstatic\b|\byield\b|\bawait\b|\blet\b|\basync\b|\breturn\b' 0:keyword

# Operators
add-highlighter shared/javascript/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Literals
add-highlighter shared/javascript/code/literal regex '\bthis\b|\bundefined\b|\bdocument\b|\bwindow\b|\bfalse\b|\btrue\b|\bnull\b|\b_G\b|\b_ENV\b|\d[\d_]*\.\w[\w]*|\d[\w]*|\b[A-Z]\w*\b' 0:value

# Comments
add-highlighter shared/javascript/line_comment region '//' '$' ref javascript.comment
add-highlighter shared/javascript/block_comment region '/\*' '\*/' ref javascript.comment

# Single quoted strings
add-highlighter shared/javascript/string.quoted.single region "'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/javascript/string.quoted.single/escaping ref javascript.string
add-highlighter shared/javascript/string.quoted.single/escaped regex "\\'" 0:value

# Double quoted strings
add-highlighter shared/javascript/string.quoted.double region '"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/javascript/string.quoted.double/escaping ref javascript.string
add-highlighter shared/javascript/string.quoted.double/escaped regex '\\"' 0:value

# Template strings
add-highlighter shared/javascript/string.quoted.template region '`' '(?<!\\)(?:\\\\)*`' group
add-highlighter shared/javascript/string.quoted.template/interpolated ref javascript.string.interpolated
add-highlighter shared/javascript/string.quoted.template/escaped regex '\\`' 0:value

# Regular expressions
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
add-highlighter shared/javascript/string.quoted.regexp region '/\H' '(?<!\\)(?:\\\\)*/[imsdguy]*' group
add-highlighter shared/javascript/string.quoted.regexp/regexp ref javascript.regexp
add-highlighter shared/javascript/string.quoted.regexp/escaped regex '\\/' 0:value
