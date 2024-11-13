# https://hexdocs.pm/elixir/
# https://discord.gg/elixir
# https://elixirforum.com/
# https://web.libera.chat/#elixir
# https://elixir-lang.org/docs.html
# https://github.com/elixir-lang/elixir
# https://elixir-lang.org/
# Syntax and semantics
# https://elixir-lang.org/reference/master/syntax_and_semantics/
alias global syntax add-highlighter

# Creates the base regions
syntax shared/elixir regions
syntax shared/elixir/code default-region group

# Method declaration and call
syntax shared/elixir/code/ regex '\bdef\h+\K(?:\w+\.|\w+::)*\w+[?!]?|\b(?:\w+\.|\w+::)*\w+[?!]?(?=\()' 0:function

# Instance and class variables
# https://elixir-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://elixir-lang.org/reference/master/syntax_and_semantics/class_variables.html
syntax shared/elixir/code/ regex '\b[A-Z]\w*\b|@@?\w+\b' 0:variable

# Keywords
# https://github.com/elixir-lang/elixir/blob/master/src/compiler/elixir/syntax/lexer.cr
syntax shared/elixir/code/ regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions
# https://elixir-lang.org/api/master/toplevel.html
# https://elixir-lang.org/api/master/Object.html
syntax shared/elixir/code/ regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b|\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Operators
# https://elixir-lang.org/reference/master/syntax_and_semantics/operators.html
syntax shared/elixir/code/ regex '[-+*/%^&!?@|<>=:(){}[\];:,.~]' 0:operator

# Literals
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/floats.html
syntax shared/elixir/code/ regex '\bthis\b|\bundefined\b|\bdocument\b|\bwindow\b|\bfalse\b|\btrue\b|\bnull\b|\b_G\b|\b_ENV\b|\b\d[\d_]*\.\w[\w]*\b|\b\d[\w]*\b|(\B[+-]|\b)\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_[iu](8|16|32|64|128))?\b|(\B[+-]|\b)\d(_?\d+)*\.\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_(f32|f64))?\b|\b0b[0-1]+(_[iu](8|16|32|64|128))?\b|\b0o[0-7]+(_[iu](8|16|32|64|128))?\b|\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Symbols
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/symbol.html
syntax shared/elixir/code/ regex '\B(?<!:):\w+[?!]?' 0:string

# Comments
# Documenting code
# https://elixir-lang.org/reference/master/syntax_and_semantics/comments.html
# https://elixir-lang.org/reference/master/syntax_and_semantics/documenting_code.html
syntax shared/elixir/line_comment region '#(?!\{)' '$' group
syntax shared/elixir/line_comment/ fill comment
syntax shared/elixir/line_comment/ regex '\B`[#.]?\w+[?!]?`\B|\B(?<!\*)\*\w+[?!]?\*(?!\*)\B|\b(?:BUG|DEPRECATED|EXPERIMENTAL|FIXME|NOTE|OPTIMIZE|TODO|WARNING)\b|\B:(?:ditto|nodoc|inherit):$' 0:meta

# Escape sequences
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping
syntax shared/elixir.escape_sequence regex '\\[\\abefnrtv]|\\[0-7]{1,3}|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:value

# Strings with escape sequences
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping
syntax shared/elixir.string_with_escape_sequences group
syntax shared/elixir.string_with_escape_sequences/ fill string
syntax shared/elixir.string_with_escape_sequences/ ref elixir.escape_sequence

# Strings with interpolation
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
syntax shared/elixir.string_with_interpolation regions
syntax shared/elixir.string_with_interpolation/content default-region group
syntax shared/elixir.string_with_interpolation/content/ fill string
syntax shared/elixir.string_with_interpolation/content/ regex '\\#' 0:value
syntax shared/elixir.string_with_interpolation/ region -recurse '\{' '[^\\]#\{\K' '(?=\})' ref elixir

# Strings with escape sequences and interpolation
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
syntax shared/elixir.string_with_escape_sequences_and_interpolation regions
syntax shared/elixir.string_with_escape_sequences_and_interpolation/content default-region group
syntax shared/elixir.string_with_escape_sequences_and_interpolation/content/ fill string
syntax shared/elixir.string_with_escape_sequences_and_interpolation/content/ ref elixir.escape_sequence
syntax shared/elixir.string_with_escape_sequences_and_interpolation/ region -recurse '\{' '[^\\]#\{\K' '(?=\})' ref elixir

# Single quoted strings
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/char.html
syntax shared/elixir/single_quoted_string region "'" "(?<!\\)(?:\\\\)*'" group
syntax shared/elixir/single_quoted_string/ fill string
syntax shared/elixir/single_quoted_string/ ref elixir.escape_sequence
syntax shared/elixir/single_quoted_string/ regex "\\'" 0:value

# Double quoted strings
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/string.html
syntax shared/elixir/double_quoted_string region '"' '(?<!\\)(?:\\\\)*"' regions
syntax shared/elixir/double_quoted_string/content default-region group
syntax shared/elixir/double_quoted_string/content/ fill string
syntax shared/elixir/double_quoted_string/content/ ref elixir.escape_sequence
syntax shared/elixir/double_quoted_string/content/ regex '\\["#]' 0:value
syntax shared/elixir/double_quoted_string/ region -recurse '\{' '[^\\]#\{\K' '(?=\})' ref elixir

# Percent string literals
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
syntax shared/elixir/ region -recurse '\(' '%Q?\(' '\)' ref elixir.string_with_escape_sequences_and_interpolation
syntax shared/elixir/ region -recurse '\[' '%Q?\[' '\]' ref elixir.string_with_escape_sequences_and_interpolation
syntax shared/elixir/ region -recurse '\{' '%Q?\{' '\}' ref elixir.string_with_escape_sequences_and_interpolation
syntax shared/elixir/ region -recurse '<' '%Q?<' '>' ref elixir.string_with_escape_sequences_and_interpolation
syntax shared/elixir/ region '%Q?\|' '\|' ref elixir.string_with_escape_sequences_and_interpolation

# Percent string and array literals
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/array.html#percent-array-literals
syntax shared/elixir/ region -recurse '\(' '%[qwi]\(' '\)' fill string
syntax shared/elixir/ region -recurse '\[' '%[qwi]\[' '\]' fill string
syntax shared/elixir/ region -recurse '\{' '%[qwi]\{' '\}' fill string
syntax shared/elixir/ region -recurse '<' '%[qwi]<' '>' fill string
syntax shared/elixir/ region '%[qwi]\|' '\|' fill string

# Here document
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc
syntax shared/elixir/ region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref elixir.string_with_escape_sequences_and_interpolation
syntax shared/elixir/ region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' fill string

# Symbols
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/symbol.html
syntax shared/elixir/quoted_symbol region ':"' '(?<!\\)(?:\\\\)*"' group
syntax shared/elixir/quoted_symbol/ fill string
syntax shared/elixir/quoted_symbol/ ref elixir.escape_sequence
syntax shared/elixir/quoted_symbol/ regex '\\"' 0:value

# Quoted regex literals
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/regex.html
syntax shared/elixir/quoted_regexp region '(?:^|\B)/(?=\H)' '(?<!\\)(?:\\\\)*/[imx]*' regions
syntax shared/elixir/quoted_regexp/content default-region group
syntax shared/elixir/quoted_regexp/content/ fill string
syntax shared/elixir/quoted_regexp/content/ regex '\\[/#]' 0:value
syntax shared/elixir/quoted_regexp/ region -recurse '\{' '[^\\]#\{\K' '(?=\})' ref elixir

# Percent regex literals
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/regex.html
syntax shared/elixir/ region -recurse '\(' '%r\(' '\)[imx]*' ref elixir.string_with_interpolation
syntax shared/elixir/ region -recurse '\[' '%r\[' '\][imx]*' ref elixir.string_with_interpolation
syntax shared/elixir/ region -recurse '\{' '%r\{' '\}[imx]*' ref elixir.string_with_interpolation
syntax shared/elixir/ region -recurse '<' '%r<' '>[imx]*' ref elixir.string_with_interpolation
syntax shared/elixir/ region '%r\|' '\|[imx]*' ref elixir.string_with_interpolation

# Quoted command literals
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/command.html
syntax shared/elixir/quoted_command region '`' '(?<!\\)(?:\\\\)*`' regions
syntax shared/elixir/quoted_command/content default-region group
syntax shared/elixir/quoted_command/content/ fill string
syntax shared/elixir/quoted_command/content/ ref elixir.escape_sequence
syntax shared/elixir/quoted_command/content/ regex '\\[`#]' 0:value
syntax shared/elixir/quoted_command/ region -recurse '\{' '[^\\]#\{\K' '(?=\})' ref elixir

# Percent command literals
# https://elixir-lang.org/reference/master/syntax_and_semantics/literals/command.html
syntax shared/elixir/ region -recurse '\(' '%x\(' '\)' ref elixir.string_with_escape_sequences_and_interpolation
syntax shared/elixir/ region -recurse '\[' '%x\[' '\]' ref elixir.string_with_escape_sequences_and_interpolation
syntax shared/elixir/ region -recurse '\{' '%x\{' '\}' ref elixir.string_with_escape_sequences_and_interpolation
syntax shared/elixir/ region -recurse '<' '%x<' '>' ref elixir.string_with_escape_sequences_and_interpolation
syntax shared/elixir/ region '%x\|' '\|' ref elixir.string_with_escape_sequences_and_interpolation
