# Creates the base regions
add-highlighter shared/crystal regions
add-highlighter shared/crystal/code default-region group

# Syntax and semantics
# https://crystal-lang.org/reference/master/syntax_and_semantics/
# Method declaration and call
# https://crystal-lang.org/reference/master/syntax_and_semantics/method_arguments.html
add-highlighter shared/crystal/code/ regex '\bdef\h+\K(?:\w+\.|\w+::)*\w+[?!]?|\b(?:\w+\.|\w+::)*\w+[?!]?(?=\()' 0:function

# Instance and class variables
# https://crystal-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/class_variables.html
add-highlighter shared/crystal/code/instance_and_class_variables regex '@@?\w+\b' 0:variable

# Keywords
# https://github.com/crystal-lang/crystal/blob/master/src/compiler/crystal/syntax/lexer.cr
add-highlighter shared/crystal/code/ regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions
# https://crystal-lang.org/api/master/toplevel.html
# https://crystal-lang.org/api/master/Object.html
add-highlighter shared/crystal/code/ regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b|\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Operators
# https://crystal-lang.org/reference/master/syntax_and_semantics/operators.html
add-highlighter shared/crystal/code/ regex '[-+*/%^&!?@|<>=:(){}[\];:,.~]' 0:operator

# Constants
# https://crystal-lang.org/reference/master/syntax_and_semantics/constants.html
add-highlighter shared/crystal/code/ regex '\b[A-Z]\w*\b' 0:variable

# Literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/floats.html
add-highlighter shared/crystal/code/ regex '\bthis\b|\bundefined\b|\bdocument\b|\bwindow\b|\bfalse\b|\btrue\b|\bnull\b|\b_G\b|\b_ENV\b|\b\d[\d_]*\.\w[\w]*\b|\b\d[\w]*\b|\b[+-]?\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_[iu](8|16|32|64|128))?\b|\b[+-]?\d(_?\d+)*\.\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_(f32|f64))?\b|\b0b[0-1]+(_[iu](8|16|32|64|128))?\b|\b0o[0-7]+(_[iu](8|16|32|64|128))?\b|\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Symbols
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html
add-highlighter shared/crystal/code/ regex '\B(?<!:):\w+[?!]?' 0:string

# Comments
# Documenting code
# https://crystal-lang.org/reference/master/syntax_and_semantics/comments.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/documenting_code.html
add-highlighter shared/crystal/comment region '#(?!\{)' '$' group
add-highlighter shared/crystal/comment/ fill comment
add-highlighter shared/crystal/comment/ regex '`[#.]?\w+[?!]?`|(?<!\*)\*\w+[?!]?\*(?!\*)' 0:mono
add-highlighter shared/crystal/comment/ regex '```(\h*\w+)?$' 0:block
add-highlighter shared/crystal/comment/ regex '\h+([A-Z]+):\h+' 1:meta
add-highlighter shared/crystal/comment/ regex ':\w+:' 0:meta

# Escape sequences
add-highlighter shared/crystal.escape_sequence regex '\\[\\abefnrtv]|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:value

# Strings
add-highlighter shared/crystal.string_with_escape_sequences group
add-highlighter shared/crystal.string_with_escape_sequences/ fill string
add-highlighter shared/crystal.string_with_escape_sequences/ ref crystal.escape_sequence

add-highlighter shared/crystal.string_with_interpolation regions
add-highlighter shared/crystal.string_with_interpolation/content default-region group
add-highlighter shared/crystal.string_with_interpolation/content/ fill string
add-highlighter shared/crystal.string_with_interpolation/ region -recurse '\{' '#\{\K' '(?=\})' ref crystal

# Interpolated strings
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html
add-highlighter shared/crystal.string_with_escape_sequences_and_interpolation regions
add-highlighter shared/crystal.string_with_escape_sequences_and_interpolation/content default-region group
add-highlighter shared/crystal.string_with_escape_sequences_and_interpolation/content/ fill string
add-highlighter shared/crystal.string_with_escape_sequences_and_interpolation/content/ ref crystal.escape_sequence
add-highlighter shared/crystal.string_with_escape_sequences_and_interpolation/ region -recurse '\{' '#\{\K' '(?=\})' ref crystal

# Single quoted strings
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/char.html
add-highlighter shared/crystal/single_quoted_string region "'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/crystal/single_quoted_string/ fill value
add-highlighter shared/crystal/single_quoted_string/ ref crystal.escape_sequence
add-highlighter shared/crystal/single_quoted_string/ regex "\\'" 0:value

# Double quoted strings
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html
add-highlighter shared/crystal/double_quoted_string region '"' '(?<!\\)(?:\\\\)*"' regions
add-highlighter shared/crystal/double_quoted_string/content default-region group
add-highlighter shared/crystal/double_quoted_string/content/ fill string
add-highlighter shared/crystal/double_quoted_string/content/ ref crystal.escape_sequence
add-highlighter shared/crystal/double_quoted_string/content/ regex '\\"' 0:value
add-highlighter shared/crystal/double_quoted_string/ region -recurse '\{' '#\{\K' '(?=\})' ref crystal

# Percent string literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
add-highlighter shared/crystal/ region -recurse '\(' '%Q?\(' '\)' ref crystal.string_with_escape_sequences_and_interpolation
add-highlighter shared/crystal/ region -recurse '\[' '%Q?\[' '\]' ref crystal.string_with_escape_sequences_and_interpolation
add-highlighter shared/crystal/ region -recurse '\{' '%Q?\{' '\}' ref crystal.string_with_escape_sequences_and_interpolation
add-highlighter shared/crystal/ region -recurse '<' '%Q?<' '>' ref crystal.string_with_escape_sequences_and_interpolation
add-highlighter shared/crystal/ region '%Q?\|' '\|' ref crystal.string_with_escape_sequences_and_interpolation

# Raw percent string literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal
add-highlighter shared/crystal/ region -recurse '\(' '%[qwi]\(' '\)' fill string
add-highlighter shared/crystal/ region -recurse '\[' '%[qwi]\[' '\]' fill string
add-highlighter shared/crystal/ region -recurse '\{' '%[qwi]\{' '\}' fill string
add-highlighter shared/crystal/ region -recurse '<' '%[qwi]<' '>' fill string
add-highlighter shared/crystal/ region '%[qwi]\|' '\|' fill string

# Here document
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc
add-highlighter shared/crystal/ region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref crystal.string_with_escape_sequences_and_interpolation
add-highlighter shared/crystal/ region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' fill string

# Symbols
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html
add-highlighter shared/crystal/quoted_symbol region ':"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/crystal/quoted_symbol/ fill string
add-highlighter shared/crystal/quoted_symbol/ ref crystal.escape_sequence
add-highlighter shared/crystal/quoted_symbol/ regex '\\"' 0:value

# Quoted regex literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html
add-highlighter shared/crystal/quoted_regexp region '(?:^|\B)/(?=\H)' '(?<!\\)(?:\\\\)*/[imx]*' regions
add-highlighter shared/crystal/quoted_regexp/content default-region group
add-highlighter shared/crystal/quoted_regexp/content/ fill string
add-highlighter shared/crystal/quoted_regexp/content/ regex '\\/' 0:value
add-highlighter shared/crystal/quoted_regexp/ region -recurse '\{' '#\{\K' '(?=\})' ref crystal

# Regular expressions
# Percent regex literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html
add-highlighter shared/crystal/ region -recurse '\(' '%r\(' '\)[imx]*' ref crystal.string_with_interpolation
add-highlighter shared/crystal/ region -recurse '\[' '%r\[' '\][imx]*' ref crystal.string_with_interpolation
add-highlighter shared/crystal/ region -recurse '\{' '%r\{' '\}[imx]*' ref crystal.string_with_interpolation
add-highlighter shared/crystal/ region -recurse '<' '%r<' '>[imx]*' ref crystal.string_with_interpolation
add-highlighter shared/crystal/ region '%r\|' '\|[imx]*' ref crystal.string_with_interpolation

# Quoted command literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html
add-highlighter shared/crystal/quoted_command region '`' '(?<!\\)(?:\\\\)*`' regions
add-highlighter shared/crystal/quoted_command/content default-region group
add-highlighter shared/crystal/quoted_command/content/ fill string
add-highlighter shared/crystal/quoted_command/content/ ref crystal.escape_sequence
add-highlighter shared/crystal/quoted_command/content/ regex '\\`' 0:value
add-highlighter shared/crystal/quoted_command/ region -recurse '\{' '#\{\K' '(?=\})' ref crystal

# Percent command literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html
add-highlighter shared/crystal/ region -recurse '\(' '%x\(' '\)' ref crystal.command_with_escape_sequences_and_interpolation
add-highlighter shared/crystal/ region -recurse '\[' '%x\[' '\]' ref crystal.command_with_escape_sequences_and_interpolation
add-highlighter shared/crystal/ region -recurse '\{' '%x\{' '\}' ref crystal.command_with_escape_sequences_and_interpolation
add-highlighter shared/crystal/ region -recurse '<' '%x<' '>' ref crystal.command_with_escape_sequences_and_interpolation
add-highlighter shared/crystal/ region '%x\|' '\|' ref crystal.command_with_escape_sequences_and_interpolation
