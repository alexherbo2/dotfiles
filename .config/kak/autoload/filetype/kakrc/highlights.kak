# This script provides support for Kakoune syntax and semantics.
# https://kakoune.org

hook global BufCreate '.+/kakrc|.+\.kak' %{
  set-option buffer filetype kakrc
}

hook global BufSetOption filetype=kakrc %{
  add-highlighter buffer/kakrc ref kakrc
  set-option buffer increase_indent_pattern '[({\[]$'
  set-option buffer decrease_indent_pattern '^\h*[)}\]]$'
  set-option buffer ignore_indent_pattern '^\h*#'
  set-option buffer line_comment_token '#'
  set-option buffer extra_word_chars '-' '_' '?' '!'
  set-option buffer static_words '%arg' '%file' '%opt' '%sh' '%val' '-always' '-buffer-completion' '-client-completion' '-command-completion' '-debug' '-docstring' '-draft' '-end-of-line' '-existing' '-fifo' '-file-completion' '-group' '-hidden' '-itersel' '-markup' '-menu' '-once' '-override' '-params' '-quoting' '-readonly' '-save-regs' '-scroll' '-shell-completion' '-shell-script-candidates' '-shell-script-completion' '-to-file' '-to-shell-script' '-verbatim' '<backspace>' '<del>' '<down>' '<end>' '<esc>' '<focus_in>' '<focus_out>' '<gt>' '<home>' '<ins>' '<left>' '<lt>' '<minus>' '<pagedown>' '<pageup>' '<percent>' '<plus>' '<ret>' '<right>' '<semicolon>' '<space>' '<tab>' '<up>' 'add-highlighter' 'addhl' 'alias' 'arrange-buffer' 'b' 'black' 'blue' 'bn' 'bool' 'bp' 'bright-black' 'bright-blue' 'bright-cyan' 'bright-green' 'bright-magenta' 'bright-red' 'bright-white' 'bright-yellow' 'buffer' 'buffer-next' 'buffer-previous' 'catch' 'cd' 'change-directory' 'colorscheme' 'column' 'compl' 'complete-command' 'completions' 'current' 'cyan' 'db' 'db!' 'debug' 'decl' 'declare-option' 'declare-user-mode' 'def' 'default' 'default-region' 'define-command' 'delete-buffer' 'delete-buffer!' 'dynregex' 'e' 'e!' 'echo' 'edit' 'edit!' 'enter-user-mode' 'eval' 'evaluate-commands' 'exec' 'execute-keys' 'face' 'fail' 'false' 'fill' 'flag-lines' 'global' 'goto' 'green' 'group' 'hook' 'info' 'insert' 'int' 'int-list' 'kakoune' 'kill' 'kill!' 'line' 'line-specs' 'magenta' 'map' 'menu' 'no' 'nop' 'normal' 'number-lines' 'object' 'on-key' 'prompt' 'provide-module' 'quit' 'quit!' 'ranges' 'ranges-specs' 'raw' 'red' 'ref' 'regex' 'region' 'regions' 'remove-highlighter' 'remove-hooks' 'rename-buffer' 'rename-client' 'rename-session' 'replace-ranges' 'require-module' 'rgb' 'rgba' 'rmhl' 'rmhooks' 'select' 'set' 'set-face' 'set-option' 'set-register' 'shared' 'shell' 'show-matching' 'show-whitespaces' 'source' 'str-list' 'str-to-str-map' 'trigger-user-hook' 'true' 'try' 'unalias' 'unmap' 'unset-face' 'unset-option' 'update-option' 'unset' 'user' 'view' 'w' 'w!' 'wa' 'waq' 'white' 'window' 'wq' 'wq!' 'wrap' 'write' 'write!' 'write-all' 'write-all-quit' 'write-quit' 'write-quit!' 'yellow' 'yes'
  hook -always -once buffer BufSetOption 'filetype=(?!kakrc).*' %{
    remove-highlighter buffer/kakrc
  }
}

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
add-highlighter shared/kakrc.expansion/expansion/ regex '%arg|%file|%opt|%val|%sh' 0:meta
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
add-highlighter shared/kakrc/code/type regex '\bstr-to-str-map\b|\branges-specs\b|\bcompletions\b|\bline-specs\b|\bstr-list\b|\bint-list\b|\bbool\b|\bint\b' 0:type
add-highlighter shared/kakrc/code/value regex '\bbright-magenta\b|\bbright-yellow\b|\bbright-white\b|\bbright-green\b|\bbright-black\b|\bbright-cyan\b|\bbright-blue\b|<semicolon>|<focus_out>|<backspace>|\bbright-red\b|<pagedown>|<focus_in>|<percent>|<pageup>|\bmagenta\b|\bkakoune\b|\bdefault\b|<space>|<right>|<minus>|\byellow\b|<plus>|<left>|<home>|<down>|\bwhite\b|\bshell\b|\bgreen\b|\bfalse\b|\bblack\b|<tab>|<ret>|<ins>|<esc>|<end>|<del>|\btrue\b|\brgba\b|\bcyan\b|\bblue\b|<up>|<lt>|<gt>|\byes\b|\brgb\b|\bred\b|\braw\b|\bno\b' 0:value

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
