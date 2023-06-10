alias global _ add-highlighter

# Creates the base regions
_ shared/crystal regions
_ shared/crystal/code default-region group

# Syntax and semantics
# https://crystal-lang.org/reference/master/syntax_and_semantics/
# Method declaration and call
# https://crystal-lang.org/reference/master/syntax_and_semantics/method_arguments.html
_ shared/crystal/code/ regex '\bdef\h+\K(?:\w+\.|\w+::)*\w+[?!]?|\b(?:\w+\.|\w+::)*\w+[?!]?(?=\()' 0:function

# Instance and class variables
# https://crystal-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/class_variables.html
_ shared/crystal/code/instance_and_class_variables regex '@@?\w+\b' 0:variable

# Keywords
# https://github.com/crystal-lang/crystal/blob/master/src/compiler/crystal/syntax/lexer.cr
_ shared/crystal/code/ regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions
# https://crystal-lang.org/api/master/toplevel.html
# https://crystal-lang.org/api/master/Object.html
_ shared/crystal/code/ regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b|\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Operators
# https://crystal-lang.org/reference/master/syntax_and_semantics/operators.html
_ shared/crystal/code/ regex '[-+*/%^&!?@|<>=:(){}[\];:,.~]' 0:operator

# Literals
# Constants
# Numbers
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/floats.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/constants.html
# FOO
# decimal number => 1_000_000
# float number => 1_000_000.111_111
# binary number => 0b1101
# octal number => 0o123
# hexadecimal number => 0xfe012d
# Symbols
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html
# :unquoted_symbol
_ shared/crystal/code/ regex ':\w+[?!]?|\bthis\b|\bundefined\b|\bdocument\b|\bwindow\b|\bfalse\b|\btrue\b|\bnull\b|\b_G\b|\b_ENV\b|\d[\d_]*\.\w[\w]*|\d[\w]*|\b[A-Z]\w*\b|\b[A-Z]\w*\b|\b[+-]?\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_[iu](8|16|32|64|128))?\b|\b[+-]?\d(_?\d+)*\.\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_(f32|f64))?\b|\b0b[0-1]+(_[iu](8|16|32|64|128))?\b|\b0o[0-7]+(_[iu](8|16|32|64|128))?\b|\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments
# https://crystal-lang.org/reference/master/syntax_and_semantics/comments.html
# Documenting code
# https://crystal-lang.org/reference/master/syntax_and_semantics/documenting_code.html
# A unicorn is a **legendary animal**.
#
# To create a unicorn:
#
# ```
# unicorn = Unicorn.new
# unicorn.speak
# ```
#
# Check the number of horns with `#horns`.
_ shared/crystal/comment region '#(?!\{)' '$' group
_ shared/crystal/comment/ fill comment
_ shared/crystal/comment/reference regex '`[#.]?\w+[?!]?`|(?<!\*)\*\w+[?!]?\*(?!\*)' 0:mono
_ shared/crystal/comment/code_block regex '```(\h*\w+)?$' 0:block
_ shared/crystal/comment/admonition regex '\h+([A-Z]+):\h+' 1:meta
_ shared/crystal/comment/directive regex ':\w+:' 0:meta

# Escape sequences
_ shared/crystal.escape_sequence regex '\\[\\abefnrtv]|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:value

# Strings
_ shared/crystal.string_with_escape_sequences group
_ shared/crystal.string_with_escape_sequences/ fill string
_ shared/crystal.string_with_escape_sequences/ ref crystal.escape_sequence

# Interpolated strings
# Interpolation
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping
# Strings
# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html
# String literal
# Examples:
#
# simple string => "hello world"
# double quote => "\""
# backslash => "\\"
#
_ shared/crystal.string_with_escape_sequences_and_interpolation regions
_ shared/crystal.string_with_escape_sequences_and_interpolation/content default-region group
_ shared/crystal.string_with_escape_sequences_and_interpolation/content/ fill string
_ shared/crystal.string_with_escape_sequences_and_interpolation/content/ ref crystal.escape_sequence
_ shared/crystal.string_with_escape_sequences_and_interpolation/ region -recurse '\{' '#\{\K' '(?=\})' ref crystal

# Single quoted strings
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/char.html
# simple character => 'a'
# single quote => '\''
# backslash => '\\'
_ shared/crystal/single_quoted_string region "'" "(?<!\\)(?:\\\\)*'" group
_ shared/crystal/single_quoted_string/ fill value
_ shared/crystal/single_quoted_string/ ref crystal.escape_sequence
_ shared/crystal/single_quoted_string/ regex "\\'" 0:value

# Double quoted strings
_ shared/crystal/double_quoted_string region '"' '(?<!\\)(?:\\\\)*"' regions
_ shared/crystal/double_quoted_string/content default-region group
_ shared/crystal/double_quoted_string/content/ fill string
_ shared/crystal/double_quoted_string/content/ ref crystal.escape_sequence
_ shared/crystal/double_quoted_string/content/ regex '\\"' 0:value
_ shared/crystal/double_quoted_string/ region -recurse '\{' '#\{\K' '(?=\})' ref crystal

# Percent string literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# puts %Q(hello #{name})
_ shared/crystal/ region -recurse '\(' '%Q?\(' '\)' ref crystal.string_with_escape_sequences_and_interpolation
_ shared/crystal/ region -recurse '\[' '%Q?\[' '\]' ref crystal.string_with_escape_sequences_and_interpolation
_ shared/crystal/ region -recurse '\{' '%Q?\{' '\}' ref crystal.string_with_escape_sequences_and_interpolation
_ shared/crystal/ region -recurse '<' '%Q?<' '>' ref crystal.string_with_escape_sequences_and_interpolation
_ shared/crystal/ region '%Q?\|' '\|' ref crystal.string_with_escape_sequences_and_interpolation

# Raw percent string literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal
# puts %q(hello world)
# puts %w(hello world)
# puts %i(hello world)
_ shared/crystal/ region -recurse '\(' '%[qwi]\(' '\)' fill string
_ shared/crystal/ region -recurse '\[' '%[qwi]\[' '\]' fill string
_ shared/crystal/ region -recurse '\{' '%[qwi]\{' '\}' fill string
_ shared/crystal/ region -recurse '<' '%[qwi]<' '>' fill string
_ shared/crystal/ region '%[qwi]\|' '\|' fill string

# Here document
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc
# <<-EOF
# EOF
# <<-'EOF'
# EOF
_ shared/crystal/ region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref crystal.string_with_escape_sequences_and_interpolation
_ shared/crystal/ region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' fill string

# Symbols
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html
# :unquoted_symbol
# :"quoted symbol"
_ shared/crystal/quoted_symbol region ':"' '(?<!\\)(?:\\\\)*"' group
_ shared/crystal/quoted_symbol/ fill value
_ shared/crystal/quoted_symbol/ ref crystal.escape_sequence
_ shared/crystal/quoted_symbol/ regex "\\'" 0:value

# Regular expressions
_ shared/crystal.regexp_with_interpolation regions
_ shared/crystal.regexp_with_interpolation/content default-region group
_ shared/crystal.regexp_with_interpolation/content/ fill meta
_ shared/crystal.regexp_with_interpolation/ region -recurse '\{' '#\{\K' '(?=\})' ref crystal

# Quoted regex literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html
# /foo/i.match("FOO")
_ shared/crystal/quoted_regexp region '(?:^|\B)/(?=\H)' '(?<!\\)(?:\\\\)*/[imx]*' regions
_ shared/crystal/quoted_regexp/content default-region group
_ shared/crystal/quoted_regexp/content/ fill meta
_ shared/crystal/quoted_regexp/content/ regex '\\/' 0:value
_ shared/crystal/quoted_regexp/ region -recurse '\{' '#\{\K' '(?=\})' ref crystal

# Percent regex literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html
# %r(foo|bar)
_ shared/crystal/ region -recurse '\(' '%r\(' '\)[imx]*' ref crystal.regexp_with_interpolation
_ shared/crystal/ region -recurse '\[' '%r\[' '\][imx]*' ref crystal.regexp_with_interpolation
_ shared/crystal/ region -recurse '\{' '%r\{' '\}[imx]*' ref crystal.regexp_with_interpolation
_ shared/crystal/ region -recurse '<' '%r<' '>[imx]*' ref crystal.regexp_with_interpolation
_ shared/crystal/ region '%r\|' '\|[imx]*' ref crystal.regexp_with_interpolation

# Command literal
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html
_ shared/crystal.command_with_escape_sequences_and_interpolation regions
_ shared/crystal.command_with_escape_sequences_and_interpolation/content default-region group
_ shared/crystal.command_with_escape_sequences_and_interpolation/content/ fill meta
_ shared/crystal.command_with_escape_sequences_and_interpolation/content/ ref crystal.escape_sequence
_ shared/crystal.command_with_escape_sequences_and_interpolation/ region -recurse '\{' '#\{\K' '(?=\})' ref crystal

# Quoted command literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html
# `echo foo`
_ shared/crystal/quoted_command region '`' '(?<!\\)(?:\\\\)*`' regions
_ shared/crystal/quoted_command/content default-region group
_ shared/crystal/quoted_command/content/ fill string
_ shared/crystal/quoted_command/content/ ref crystal.escape_sequence
_ shared/crystal/quoted_command/content/ regex '\\`' 0:value
_ shared/crystal/quoted_command/ region -recurse '\{' '#\{\K' '(?=\})' ref crystal

# Percent command literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html
# %x(echo foo)
_ shared/crystal/ region -recurse '\(' '%x\(' '\)' ref crystal.command_with_escape_sequences_and_interpolation
_ shared/crystal/ region -recurse '\[' '%x\[' '\]' ref crystal.command_with_escape_sequences_and_interpolation
_ shared/crystal/ region -recurse '\{' '%x\{' '\}' ref crystal.command_with_escape_sequences_and_interpolation
_ shared/crystal/ region -recurse '<' '%x<' '>' ref crystal.command_with_escape_sequences_and_interpolation
_ shared/crystal/ region '%x\|' '\|' ref crystal.command_with_escape_sequences_and_interpolation
