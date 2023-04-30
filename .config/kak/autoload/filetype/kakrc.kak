# Kakoune
# https://kakoune.org

# Configuration ────────────────────────────────────────────────────────────────

# Word pattern
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#word-pattern
declare-option -docstring 'Kakoune word pattern' str kakrc_word_pattern '\w+[?!]?'

# Detection ────────────────────────────────────────────────────────────────────

# Sets Kakoune filetype when opening `.cr` files.
hook global BufCreate '.+/kakrc|.+\.kak' %{
  set-option buffer filetype kakrc
}

# Enables syntax highlighting for Kakoune filetype.
# Configures word selection and completion for Kakoune filetype.
hook global BufSetOption filetype=kakrc %{
  add-highlighter buffer/kakrc ref kakrc
  set-option buffer increase_indent_pattern '^\h*(if|elsif|else|unless|case|when|case|in|while|until|class|private\h+class|abstract\h+class|private\h+abstract\h+class|def|private\h+def|protected\h+def|module|private\h+module|struct|private\h+struct|abstract\h+struct|private\h+abstract\h+struct|enum|private\h+enum|begin|rescue|ensure|macro|annotation|lib|private\h+lib)[^;]*$|\h(do)[^;]*$|\w+\h*=\h*(if|unless|case|begin)[^;]*$'
  set-option buffer decrease_indent_pattern '^\h*(elsif|else|end|when|in|rescue|ensure)$'
  set-option buffer ignore_indent_pattern '^\h*#'
  set-option buffer line_comment_token '#'
  set-option buffer extra_word_chars '-' '_' '?' '!'
  set-option buffer static_words 'add-highlighter' 'addhl' 'alias' 'arrange-buffer' 'buffer' 'b' 'buffer-next' 'bn' 'buffer-previous' 'bp' 'catch' 'change-directory' 'cd' 'colorscheme' 'debug' 'declare-option' 'decl' 'declare-user-mode' 'define-command' 'def' 'complete-command' 'compl' 'delete-buffer' 'db' 'db!' 'delete-buffer!' 'echo' 'edit' 'e' 'e!' 'edit!' 'enter-user-mode' 'evaluate-commands' 'eval' 'execute-keys' 'exec' 'fail' 'hook' 'info' 'kill' 'kill!' 'map' 'menu' 'nop' 'on-key' 'prompt' 'provide-module' 'quit' 'quit!' 'remove-highlighter' 'rmhl' 'remove-hooks' 'rmhooks' 'rename-buffer' 'rename-client' 'rename-session' 'require-module' 'select' 'face' 'set-face' 'set' 'set-option' 'set-register' 'source' 'trigger-user-hook' 'try' 'unalias' 'unmap' 'unset-face' 'set-option' 'update-option' 'write' 'w' 'w!' 'wq' 'wq!' 'write!' 'write-all' 'wa' 'waq' 'write-all-quit' 'write-quit' 'write-quit!' 'global' 'buffer' 'window' 'shared' 'current' 'normal' 'insert' 'menu' 'prompt' 'goto' 'view' 'user' 'object' 'number-lines' 'show-matching' 'show-whitespaces' 'fill' 'regex' 'dynregex' 'group' 'flag-lines' 'ranges' 'line' 'column' 'wrap' 'ref' 'regions' 'region' 'default-region' 'replace-ranges' 'int' 'bool' 'int-list' 'str-list' 'completions' 'line-specs' 'ranges-specs' 'str-to-str-map' '-hidden' '-docstring' '-buffer-completion' '-client-completion' '-shell-completion' '-file-completion' '-command-completion' '-menu' '-params' '-shell-script-candidates' '-shell-script-completion' '-draft' '-itersel' '-quoting' '-to-file' '-to-shell-script' '-markup' '-debug' '-existing' '-fifo' '-readonly' '-verbatim' '-scroll' '-override' '-save-regs' '-always' '-once' '-group' '-end-of-line' '%arg' '%file' '%opt' '%val' '%sh' 'rgb' 'rgba' 'shell' 'raw' 'kakrc' 'default' 'black' 'red' 'green' 'yellow' 'blue' 'magenta' 'cyan' 'white' 'bright-black' 'bright-red' 'bright-green' 'bright-yellow' 'bright-blue' 'bright-magenta' 'bright-cyan' 'bright-white' 'yes' 'no' 'false' 'true' '<semicolon>' '<ret>' '<esc>' '<down>' '<up>' '<left>' '<right>' '<pageup>' '<pagedown>' '<gt>' '<lt>' '<tab>' '<backspace>' '<space>' '<home>' '<end>' '<ins>' '<del>' '<plus>' '<minus>' '<percent>' '<focus_in>' '<focus_out>'
  hook -always -once buffer BufSetOption 'filetype=(?!kakrc).*' %{
    unset-option buffer line_comment_token
    unset-option buffer extra_word_chars
    unset-option buffer static_words
    remove-highlighter buffer/kakrc
  }
}

# Highlighters ─────────────────────────────────────────────────────────────────

# Creates the base regions
add-highlighter shared/kakrc regions
add-highlighter shared/kakrc/code default-region group

# Keywords
add-highlighter shared/kakrc/code/keyword regex '\badd-highlighter\b|\baddhl\b|\balias\b|\barrange-buffer\b|\bbuffer\b|\bb\b|\bbuffer-next\b|\bbn\b|\bbuffer-previous\b|\bbp\b|\bcatch\b|\bchange-directory\b|\bcd\b|\bcolorscheme\b|\bdebug\b|\bdeclare-option\b|\bdecl\b|\bdeclare-user-mode\b|\bdefine-command\b|\bdef\b|\bcomplete-command\b|\bcompl\b|\bdelete-buffer\b|\bdb\b|\bdb!\b|\bdelete-buffer!\b|\becho\b|\bedit\b|\be\b|\be!\b|\bedit!\b|\benter-user-mode\b|\bevaluate-commands\b|\beval\b|\bexecute-keys\b|\bexec\b|\bfail\b|\bhook\b|\binfo\b|\bkill\b|\bkill!\b|\bmap\b|\bmenu\b|\bnop\b|\bon-key\b|\bprompt\b|\bprovide-module\b|\bquit\b|\bquit!\b|\bremove-highlighter\b|\brmhl\b|\bremove-hooks\b|\brmhooks\b|\brename-buffer\b|\brename-client\b|\brename-session\b|\brequire-module\b|\bselect\b|\bface\b|\bset-face\b|\bset\b|\bset-option\b|\bset-register\b|\bsource\b|\btrigger-user-hook\b|\btry\b|\bunalias\b|\bunmap\b|\bunset-face\b|\bset-option\b|\bupdate-option\b|\bwrite\b|\bw\b|\bw!\b|\bwq\b|\bwq!\b|\bwrite!\b|\bwrite-all\b|\bwa\b|\bwaq\b|\bwrite-all-quit\b|\bwrite-quit\b|\bwrite-quit!\b' 0:keyword
add-highlighter shared/kakrc/code/attribute regex '\bglobal\b|\bbuffer\b|\bwindow\b|\bshared\b|\bcurrent\b|\bnormal\b|\binsert\b|\bmenu\b|\bprompt\b|\bgoto\b|\bview\b|\buser\b|\bobject\b|\bnumber-lines\b|\bshow-matching\b|\bshow-whitespaces\b|\bfill\b|\bregex\b|\bdynregex\b|\bgroup\b|\bflag-lines\b|\branges\b|\bline\b|\bcolumn\b|\bwrap\b|\bref\b|\bregions\b|\bregion\b|\bdefault-region\b|\breplace-ranges\b|\b-hidden\b|\b-docstring\b|\b-buffer-completion\b|\b-client-completion\b|\b-shell-completion\b|\b-file-completion\b|\b-command-completion\b|\b-menu\b|\b-params\b|\b-shell-script-candidates\b|\b-shell-script-completion\b|\b-draft\b|\b-itersel\b|\b-quoting\b|\b-to-file\b|\b-to-shell-script\b|\b-markup\b|\b-debug\b|\b-existing\b|\b-fifo\b|\b-readonly\b|\b-verbatim\b|\b-scroll\b|\b-override\b|\b-save-regs\b|\b-always\b|\b-once\b|\b-group\b|\b-end-of-line\b' 0:attribute
add-highlighter shared/kakrc/code/type regex '\bint\b|\bbool\b|\bint-list\b|\bstr-list\b|\bcompletions\b|\bline-specs\b|\branges-specs\b|\bstr-to-str-map\b' 0:type
add-highlighter shared/kakrc/code/value regex '\brgb\b|\brgba\b|\bshell\b|\braw\b|\bkakrc\b|\bdefault\b|\bblack\b|\bred\b|\bgreen\b|\byellow\b|\bblue\b|\bmagenta\b|\bcyan\b|\bwhite\b|\bbright-black\b|\bbright-red\b|\bbright-green\b|\bbright-yellow\b|\bbright-blue\b|\bbright-magenta\b|\bbright-cyan\b|\bbright-white\b|\byes\b|\bno\b|\bfalse\b|\btrue\b|\b<semicolon>\b|\b<ret>\b|\b<esc>\b|\b<down>\b|\b<up>\b|\b<left>\b|\b<right>\b|\b<pageup>\b|\b<pagedown>\b|\b<gt>\b|\b<lt>\b|\b<tab>\b|\b<backspace>\b|\b<space>\b|\b<home>\b|\b<end>\b|\b<ins>\b|\b<del>\b|\b<plus>\b|\b<minus>\b|\b<percent>\b|\b<focus_in>\b|\b<focus_out>\b' 0:value
add-highlighter shared/kakrc/code/meta regex '%arg|%file|%opt|%val|%sh' 0:meta

# Numbers
add-highlighter shared/kakrc/code/constant.numeric.integer.decimal regex '\b\d+\b' 0:value

# Colors
add-highlighter shared/kakrc/code/constant.color.rgb regex '\b(rgb:[0-9a-fA-F]{6})\b' 0:value
add-highlighter shared/kakrc/code/constant.color.rgba regex '\b(rgba:[0-9a-fA-F]{8})\b' 0:value

# Comments
add-highlighter shared/kakrc/comment region '(^|\h)\K#' '$' group
add-highlighter shared/kakrc/comment/fill fill comment

# Strings
add-highlighter shared/kakrc/string.quoted.single region -recurse "(?<!')('')+(?!')" "(^|\h)\K'" "'(?!')" regions
add-highlighter shared/kakrc/string.quoted.single/content default-region group
add-highlighter shared/kakrc/string.quoted.single/content/fill fill value
add-highlighter shared/kakrc/string.quoted.single/content/escaped-character regex "''" 0:meta

add-highlighter shared/kakrc/string.quoted.double region -recurse '(?<!")("")+(?!")' '(^|\h)\K"' '"(?!")' regions
add-highlighter shared/kakrc/string.quoted.double/content default-region group
add-highlighter shared/kakrc/string.quoted.double/content/fill fill string
add-highlighter shared/kakrc/string.quoted.double/content/escaped-character regex '""' 0:meta

add-highlighter shared/kakrc/string.quoted.percent.parenthesis region -recurse '\(' '(^|\h)\K%?%sh\(' '\)' ref sh
add-highlighter shared/kakrc/string.quoted.percent.bracket region -recurse '\[' '(^|\h)\K%?%sh\[' '\]' ref sh
add-highlighter shared/kakrc/string.quoted.percent.brace region -recurse '\{' '(^|\h)\K%?%sh\{' '\}' ref sh
add-highlighter shared/kakrc/string.quoted.percent.angle region -recurse '<' '(^|\h)\K%?%sh<' '>' ref sh

add-highlighter shared/kakrc/string.quoted.percent.parenthesis.with_option region -recurse '\(' '(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+%\(' '\)' ref sh
add-highlighter shared/kakrc/string.quoted.percent.bracket.with_option region -recurse '\[' '(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+%\[' '\]' ref sh
add-highlighter shared/kakrc/string.quoted.percent.brace.with_option region -recurse '\{' '(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+%\{' '\}' ref sh
add-highlighter shared/kakrc/string.quoted.percent.angle.with_option region -recurse '<' '(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+%<' '>' ref sh

add-highlighter shared/kakrc/string.quoted.single.with_option region -recurse "(?<!')('')+(?!')" "(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+'" "'(?!')" ref sh
add-highlighter shared/kakrc/string.quoted.double.with_option region -recurse '(?<!")("")+(?!")' '(^|\h)\K(-shell-script-candidates|-shell-script-completion|shell-script-candidates|shell-script-completion)\h+"' '"(?!")' ref sh
