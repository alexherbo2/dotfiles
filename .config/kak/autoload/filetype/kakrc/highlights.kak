# Creates the base regions
add-highlighter shared/kakrc regions
add-highlighter shared/kakrc/code default-region group

# Comments
add-highlighter shared/kakrc.comment regions
add-highlighter shared/kakrc.comment/comment default-region group
add-highlighter shared/kakrc.comment/comment/ fill comment

# Strings
add-highlighter shared/kakrc.string regions
add-highlighter shared/kakrc.string/string default-region group
add-highlighter shared/kakrc.string/string/ fill string

# Interpolated strings
add-highlighter shared/kakrc.string.interpolated regions
add-highlighter shared/kakrc.string.interpolated/string default-region group
add-highlighter shared/kakrc.string.interpolated/string/ fill string
add-highlighter shared/kakrc.string.interpolated/string/ ref kakrc.expansion

# Expansions
add-highlighter shared/kakrc.expansion regions
add-highlighter shared/kakrc.expansion/expansion default-region group
add-highlighter shared/kakrc.expansion/expansion/ regex '\B%(arg|file|opt|val|sh)\b' 0:meta
add-highlighter shared/kakrc.expansion/ region -recurse '\(' '[^%]%sh\(\K' '(?=\))' ref sh
add-highlighter shared/kakrc.expansion/ region -recurse '\[' '[^%]%sh\[\K' '(?=\])' ref sh
add-highlighter shared/kakrc.expansion/ region -recurse '\{' '[^%]%sh\{\K' '(?=\})' ref sh
add-highlighter shared/kakrc.expansion/ region -recurse '<' '[^%]%sh<\K' '(?=>)' ref sh

# Syntax and semantics
add-highlighter shared/kakrc/code/constant.numeric.integer.decimal regex '\b\d+\b' 0:value
add-highlighter shared/kakrc/code/expansion ref kakrc.expansion

# Keywords
add-highlighter shared/kakrc/code/keyword regex '\bremove-highlighter\b|\btrigger-user-hook\b|\bevaluate-commands\b|\bdeclare-user-mode\b|\bcomplete-command\b|\bchange-directory\b|\benter-user-mode\b|\bbuffer-previous\b|\badd-highlighter\b|\bwrite-all-quit\b|\brequire-module\b|\brename-session\b|\bprovide-module\b|\bdelete-buffer!|\bdefine-command\b|\bdeclare-option\b|\barrange-buffer\b|\bupdate-option\b|\brename-client\b|\brename-buffer\b|\bdelete-buffer\b|\bset-register\b|\bremove-hooks\b|\bexecute-keys\b|\bwrite-quit!|\bcolorscheme\b|\bbuffer-next\b|\bwrite-quit\b|\bunset-face\b|\bset-option\b|\bwrite-all\b|\bset-face\b|\bunalias\b|\brmhooks\b|\bwrite!|\bsource\b|\bselect\b|\bprompt\b|\bon-key\b|\bbuffer\b|\bwrite\b|\bunmap\b|\bquit!|\bkill!|\bedit!|\bdebug\b|\bcompl\b|\bcatch\b|\balias\b|\baddhl\b|\brmhl\b|\bquit\b|\bmenu\b|\bkill\b|\binfo\b|\bhook\b|\bfail\b|\bface\b|\bexec\b|\beval\b|\bedit\b|\becho\b|\bdecl\b|\bwq!|\bwaq\b|\btry\b|\bset\b|\bnop\b|\bmap\b|\bdef\b|\bdb!|\bwq\b|\bwa\b|\bw!|\be!|\bdb\b|\bcd\b|\bbp\b|\bbn\b|\bw\b|\be\b|\bb\b|\bunset-option\b|\bunset\b' 0:keyword
add-highlighter shared/kakrc/code/attribute regex '-shell-script-completion\b|-shell-script-candidates\b|-command-completion\b|-client-completion\b|-buffer-completion\b|-shell-completion\b|\bshow-whitespaces\b|-to-shell-script\b|-file-completion\b|\breplace-ranges\b|\bdefault-region\b|\bshow-matching\b|\bnumber-lines\b|-end-of-line\b|\bflag-lines\b|-save-regs\b|-docstring\b|-verbatim\b|-readonly\b|-override\b|-existing\b|\bdynregex\b|-to-file\b|-quoting\b|-itersel\b|\bregions\b|\bcurrent\b|-scroll\b|-params\b|-markup\b|-hidden\b|-always\b|\bwindow\b|\bshared\b|\bregion\b|\branges\b|\bprompt\b|\bobject\b|\bnormal\b|\binsert\b|\bglobal\b|\bcolumn\b|\bbuffer\b|-group\b|-draft\b|-debug\b|\bregex\b|\bgroup\b|-once\b|-menu\b|-fifo\b|\bwrap\b|\bview\b|\buser\b|\bmenu\b|\bline\b|\bgoto\b|\bfill\b|\bref\b' 0:attribute
add-highlighter shared/kakrc/code/literal regex '\B--\B|\B-\w[\w-]*\b|\b\d\w*\b' 0:value
add-highlighter shared/kakrc/code/type regex '\bstr-to-str-map\b|\brange-specs\b|\bcompletions\b|\bline-specs\b|\bstr-list\b|\bint-list\b|\bbool\b|\bint\b' 0:type
add-highlighter shared/kakrc/code/value regex '\bbright-magenta\b|\bbright-yellow\b|\bbright-white\b|\bbright-green\b|\bbright-black\b|\bbright-cyan\b|\bbright-blue\b|<semicolon>|<focus_out>|<backspace>|\bbright-red\b|<pagedown>|<focus_in>|<percent>|<pageup>|\bmagenta\b|\bkakoune\b|\bdefault\b|<space>|<right>|<minus>|\byellow\b|<plus>|<left>|<home>|<down>|\bwhite\b|\bshell\b|\bgreen\b|\bfalse\b|\bblack\b|<[cas]-[a-z]+>|<tab>|<ret>|<ins>|<esc>|<end>|<del>|\btrue\b|\brgba\b|\bcyan\b|\bblue\b|<up>|<lt>|<gt>|\byes\b|\brgb\b|\bred\b|\braw\b|\bno\b' 0:value

# Comments
add-highlighter shared/kakrc/comment region '(^|\h)\K#' '$' ref kakrc.comment

# Single quoted strings
add-highlighter shared/kakrc/string.quoted.single region -recurse "(?<!')('')+(?!')" "(^|\h)\K'" "'(?!')" group
add-highlighter shared/kakrc/string.quoted.single/escaped regex "''" 0:value
add-highlighter shared/kakrc/string.quoted.single/raw ref kakrc.string

# Double quoted strings
add-highlighter shared/kakrc/string.quoted.double region -recurse '(?<!")("")+(?!")' '(^|\h)\K"' '"(?!")' group
add-highlighter shared/kakrc/string.quoted.double/escaped regex '""|%%' 0:value
add-highlighter shared/kakrc/string.quoted.double/interpolated ref kakrc.string.interpolated

# Command completion via shell scripts
add-highlighter shared/kakrc/string.quoted.single.completion.shell region -recurse "(?<!')('')+(?!')" "(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+'" "'(?!')" ref sh
add-highlighter shared/kakrc/string.quoted.double.completion.shell region -recurse '(?<!")("")+(?!")' '(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+"' '"(?!")' ref sh
add-highlighter shared/kakrc/string.balanced.parenthesis.completion.shell region -recurse '\(' '(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+%\(' '\)' ref sh
add-highlighter shared/kakrc/string.balanced.bracket.completion.shell region -recurse '\[' '(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+%\[' '\]' ref sh
add-highlighter shared/kakrc/string.balanced.brace.completion.shell region -recurse '\{' '(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+%\{' '\}' ref sh
add-highlighter shared/kakrc/string.balanced.angle.completion.shell region -recurse '<' '(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+%<' '>' ref sh
