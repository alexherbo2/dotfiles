# Creates the base regions
add-highlighter shared/troff regions
add-highlighter shared/troff/code default-region group

# Comments
add-highlighter shared/troff.comment regions
add-highlighter shared/troff.comment/comment default-region group
add-highlighter shared/troff.comment/comment/ fill comment

# Strings
add-highlighter shared/troff.string regions
add-highlighter shared/troff.string/string default-region group
add-highlighter shared/troff.string/string/ fill string

# Interpolated strings
add-highlighter shared/troff.string.interpolated regions
add-highlighter shared/troff.string.interpolated/string default-region group
add-highlighter shared/troff.string.interpolated/string/ fill string
add-highlighter shared/troff.string.interpolated/string/ ref troff.variable
add-highlighter shared/troff.string.interpolated/ region -recurse '\(' '\$\(\K' '(?=\))' ref troff

# Variables
add-highlighter shared/troff.variable regions
add-highlighter shared/troff.variable/variable default-region group
add-highlighter shared/troff.variable/variable/ regex '(?<!\\)(?:\\\\)*\$\K(?:\w+|[#@?$!*-])' 0:variable
add-highlighter shared/troff.variable/variable/ regex '\$' 0:operator
add-highlighter shared/troff.variable/ region -recurse '\{' '\$\{\K' '(?=\})' fill variable

# Syntax and semantics
add-highlighter shared/troff/code/function_name_declaration regex '^\h*\K\w+(?=\(\))' 0:function
add-highlighter shared/troff/code/variable_name_declaration regex '\b\w+(?==)' 0:variable
add-highlighter shared/troff/code/alias_name_declaration regex '^\h*alias\h*\K[\w.-]+(?==)' 0:variable
add-highlighter shared/troff/code/variable ref troff.variable

# Keywords
# compgen -k
add-highlighter shared/troff/code/keyword regex '\bif\b|\bthen\b|\belse\b|\belif\b|\bfi\b|\bcase\b|\besac\b|\bfor\b|\bselect\b|\bwhile\b|\buntil\b|\bdo\b|\bdone\b|\bin\b|\bfunction\b|\btime\b|\{|\}|!|\[\[|\]\]|\bcoproc\b' 0:keyword

# Built-in functions
# compgen -b
add-highlighter shared/troff/code/builtin regex '\.|:|\[|\balias\b|\bbg\b|\bbind\b|\bbreak\b|\bbuiltin\b|\bcaller\b|\bcd\b|\bcommand\b|\bcompgen\b|\bcomplete\b|\bcompopt\b|\bcontinue\b|\bdeclare\b|\bdirs\b|\bdisown\b|\becho\b|\benable\b|\beval\b|\bexec\b|\bexit\b|\bexport\b|\bfalse\b|\bfc\b|\bfg\b|\bgetopts\b|\bhash\b|\bhelp\b|\bhistory\b|\bjobs\b|\bkill\b|\blet\b|\blocal\b|\blogout\b|\bmapfile\b|\bpopd\b|\bprintf\b|\bpushd\b|\bpwd\b|\bread\b|\breadarray\b|\breadonly\b|\breturn\b|\bset\b|\bshift\b|\bshopt\b|\bsource\b|\bsuspend\b|\btest\b|\btimes\b|\btrap\b|\btrue\b|\btype\b|\btypeset\b|\bulimit\b|\bumask\b|\bunalias\b|\bunset\b|\bwait\b' 0:builtin

# Operators
add-highlighter shared/troff/code/operator regex '[()[\]{}<>=~*&!|@;$]' 0:operator
# Literals
add-highlighter shared/troff/code/literal regex '\B-{1,2}\B|\B-{1,2}\w[\w-]*\b|\b\d\w*\b' 0:value

# Comments
add-highlighter shared/troff/comment region '(?<!\\)(?:\\\\)*(^|\h)\K#' '$' ref troff.comment

# Single quoted strings
add-highlighter shared/troff/string.quoted.single region "(?<!\\)(?:\\\\)*\K'" "'" ref troff.string

# Double quoted strings
add-highlighter shared/troff/string.quoted.double region '(?<!\\)(?:\\\\)*\K"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/troff/string.quoted.double/escaped regex '\\"' 0:value
add-highlighter shared/troff/string.quoted.double/interpolated ref troff.string.interpolated

# Here document
add-highlighter shared/troff/string.unquoted.heredoc region -match-capture '<<-(\w+)' '^(\w+)$' ref troff.string.interpolated
add-highlighter shared/troff/string.unquoted.heredoc.indent region -match-capture '<<-(\w+)' '^\t*(\w+)$' ref troff.string.interpolated
add-highlighter shared/troff/string.quoted.single.heredoc region -match-capture "<<-'(\w+)'" '^(\w+)$' ref troff.string
add-highlighter shared/troff/string.quoted.single.heredoc.indent region -match-capture "<<-'(\w+)'" '^\t*(\w+)$' ref troff.string
add-highlighter shared/troff/string.quoted.double.heredoc region -match-capture '<<-"(\w+)"' '^(\w+)$' ref troff.string
add-highlighter shared/troff/string.quoted.double.heredoc.indent region -match-capture '<<-"(\w+)"' '^\t*(\w+)$' ref troff.string
