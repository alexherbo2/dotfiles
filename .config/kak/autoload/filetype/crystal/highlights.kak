# Syntax and semantics
# https://crystal-lang.org/reference/master/syntax_and_semantics/
alias global syntax add-highlighter

# Creates the base regions
syntax shared/crystal regions
syntax shared/crystal/code default-region group

# Method declaration and call
syntax shared/crystal/code/ regex '\bdef\h+\K(?:\w+\.|\w+::)*\w+[?!]?|\b(?:\w+\.|\w+::)*\w+[?!]?(?=\()' 0:function

# Instance and class variables
# https://crystal-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/class_variables.html
syntax shared/crystal/code/ regex '\b[A-Z]\w*\b|@@?\w+\b' 0:variable

# Keywords
# https://github.com/crystal-lang/crystal/blob/master/src/compiler/crystal/syntax/lexer.cr
syntax shared/crystal/code/ regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions
# https://crystal-lang.org/api/master/toplevel.html
# https://crystal-lang.org/api/master/Object.html
syntax shared/crystal/code/ regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b|\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Operators
# https://crystal-lang.org/reference/master/syntax_and_semantics/operators.html
syntax shared/crystal/code/ regex '[-+*/%^&!?@|<>=:(){}[\];:,.~]' 0:operator

# Literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/floats.html
syntax shared/crystal/code/ regex '\bthis\b|\bundefined\b|\bdocument\b|\bwindow\b|\bfalse\b|\btrue\b|\bnull\b|\b_G\b|\b_ENV\b|\b\d[\d_]*\.\w[\w]*\b|\b\d[\w]*\b|(\B[+-]|\b)\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_[iu](8|16|32|64|128))?\b|(\B[+-]|\b)\d(_?\d+)*\.\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_(f32|f64))?\b|\b0b[0-1]+(_[iu](8|16|32|64|128))?\b|\b0o[0-7]+(_[iu](8|16|32|64|128))?\b|\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Symbols
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html
syntax shared/crystal/code/ regex '\B(?<!:):\w+[?!]?' 0:string

# Comments
# Documenting code
# https://crystal-lang.org/reference/master/syntax_and_semantics/comments.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/documenting_code.html
syntax shared/crystal/comment region '#(?!\{)' '$' group
syntax shared/crystal/comment/ fill comment
syntax shared/crystal/comment/ regex '\B`[#.]?\w+[?!]?`\B|\B(?<!\*)\*\w+[?!]?\*(?!\*)\B|\b(?:BUG|DEPRECATED|EXPERIMENTAL|FIXME|NOTE|OPTIMIZE|TODO|WARNING)\b|\B:(?:ditto|nodoc|inherit):$' 0:meta

# Escape sequences
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping
syntax shared/crystal.escape_sequence regex '\\[\\abefnrtv]|\\[0-7]{1,3}|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:value

# Strings with escape sequences
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping
syntax shared/crystal.string_with_escape_sequences group
syntax shared/crystal.string_with_escape_sequences/ fill string
syntax shared/crystal.string_with_escape_sequences/ ref crystal.escape_sequence

# Strings with interpolation
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
syntax shared/crystal.string_with_interpolation regions
syntax shared/crystal.string_with_interpolation/content default-region group
syntax shared/crystal.string_with_interpolation/content/ fill string
syntax shared/crystal.string_with_interpolation/content/ regex '\\#' 0:value
syntax shared/crystal.string_with_interpolation/ region -recurse '\{' '[^\\]#\{\K' '(?=\})' ref crystal

# Strings with escape sequences and interpolation
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
syntax shared/crystal.string_with_escape_sequences_and_interpolation regions
syntax shared/crystal.string_with_escape_sequences_and_interpolation/content default-region group
syntax shared/crystal.string_with_escape_sequences_and_interpolation/content/ fill string
syntax shared/crystal.string_with_escape_sequences_and_interpolation/content/ ref crystal.escape_sequence
syntax shared/crystal.string_with_escape_sequences_and_interpolation/ region -recurse '\{' '[^\\]#\{\K' '(?=\})' ref crystal

# Single quoted strings
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/char.html
syntax shared/crystal/single_quoted_string region "'" "(?<!\\)(?:\\\\)*'" group
syntax shared/crystal/single_quoted_string/ fill string
syntax shared/crystal/single_quoted_string/ ref crystal.escape_sequence
syntax shared/crystal/single_quoted_string/ regex "\\'" 0:value

# Double quoted strings
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html
syntax shared/crystal/double_quoted_string region '"' '(?<!\\)(?:\\\\)*"' regions
syntax shared/crystal/double_quoted_string/content default-region group
syntax shared/crystal/double_quoted_string/content/ fill string
syntax shared/crystal/double_quoted_string/content/ ref crystal.escape_sequence
syntax shared/crystal/double_quoted_string/content/ regex '\\["#]' 0:value
syntax shared/crystal/double_quoted_string/ region -recurse '\{' '[^\\]#\{\K' '(?=\})' ref crystal

# Percent string literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
syntax shared/crystal/ region -recurse '\(' '%Q?\(' '\)' ref crystal.string_with_escape_sequences_and_interpolation
syntax shared/crystal/ region -recurse '\[' '%Q?\[' '\]' ref crystal.string_with_escape_sequences_and_interpolation
syntax shared/crystal/ region -recurse '\{' '%Q?\{' '\}' ref crystal.string_with_escape_sequences_and_interpolation
syntax shared/crystal/ region -recurse '<' '%Q?<' '>' ref crystal.string_with_escape_sequences_and_interpolation
syntax shared/crystal/ region '%Q?\|' '\|' ref crystal.string_with_escape_sequences_and_interpolation

# Percent string and array literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/array.html#percent-array-literals
syntax shared/crystal/ region -recurse '\(' '%[qwi]\(' '\)' fill string
syntax shared/crystal/ region -recurse '\[' '%[qwi]\[' '\]' fill string
syntax shared/crystal/ region -recurse '\{' '%[qwi]\{' '\}' fill string
syntax shared/crystal/ region -recurse '<' '%[qwi]<' '>' fill string
syntax shared/crystal/ region '%[qwi]\|' '\|' fill string

# Here document
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc
syntax shared/crystal/ region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref crystal.string_with_escape_sequences_and_interpolation
syntax shared/crystal/ region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' fill string

# Symbols
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html
syntax shared/crystal/quoted_symbol region ':"' '(?<!\\)(?:\\\\)*"' group
syntax shared/crystal/quoted_symbol/ fill string
syntax shared/crystal/quoted_symbol/ ref crystal.escape_sequence
syntax shared/crystal/quoted_symbol/ regex '\\"' 0:value

# Quoted regex literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html
syntax shared/crystal/quoted_regexp region '(?:^|\B)/(?=\H)' '(?<!\\)(?:\\\\)*/[imx]*' regions
syntax shared/crystal/quoted_regexp/content default-region group
syntax shared/crystal/quoted_regexp/content/ fill string
syntax shared/crystal/quoted_regexp/content/ regex '\\[/#]' 0:value
syntax shared/crystal/quoted_regexp/ region -recurse '\{' '[^\\]#\{\K' '(?=\})' ref crystal

# Percent regex literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html
syntax shared/crystal/ region -recurse '\(' '%r\(' '\)[imx]*' ref crystal.string_with_interpolation
syntax shared/crystal/ region -recurse '\[' '%r\[' '\][imx]*' ref crystal.string_with_interpolation
syntax shared/crystal/ region -recurse '\{' '%r\{' '\}[imx]*' ref crystal.string_with_interpolation
syntax shared/crystal/ region -recurse '<' '%r<' '>[imx]*' ref crystal.string_with_interpolation
syntax shared/crystal/ region '%r\|' '\|[imx]*' ref crystal.string_with_interpolation

# Quoted command literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html
syntax shared/crystal/quoted_command region '`' '(?<!\\)(?:\\\\)*`' regions
syntax shared/crystal/quoted_command/content default-region group
syntax shared/crystal/quoted_command/content/ fill string
syntax shared/crystal/quoted_command/content/ ref crystal.escape_sequence
syntax shared/crystal/quoted_command/content/ regex '\\[`#]' 0:value
syntax shared/crystal/quoted_command/ region -recurse '\{' '[^\\]#\{\K' '(?=\})' ref crystal

# Percent command literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html
syntax shared/crystal/ region -recurse '\(' '%x\(' '\)' ref crystal.string_with_escape_sequences_and_interpolation
syntax shared/crystal/ region -recurse '\[' '%x\[' '\]' ref crystal.string_with_escape_sequences_and_interpolation
syntax shared/crystal/ region -recurse '\{' '%x\{' '\}' ref crystal.string_with_escape_sequences_and_interpolation
syntax shared/crystal/ region -recurse '<' '%x<' '>' ref crystal.string_with_escape_sequences_and_interpolation
syntax shared/crystal/ region '%x\|' '\|' ref crystal.string_with_escape_sequences_and_interpolation
