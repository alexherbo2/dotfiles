#===============
# add-highlighter shared/kakrc regions
# add-highlighter shared/kakrc/code default-region group
# add-highlighter shared/kakrc/comment region (^|\h)\K# $ fill comment
# add-highlighter shared/kakrc/double_string region -recurse %{(?<!")("")+(?!")} %{(^|\h)\K"} %{"(?!")} group
# add-highlighter shared/kakrc/single_string region -recurse %{(?<!')('')+(?!')} %{(^|\h)\K'} %{'(?!')} group
# add-highlighter shared/kakrc/shell1 region -recurse '\{' '(^|\h)\K%?%sh\{' '\}' ref sh
# add-highlighter shared/kakrc/shell2 region -recurse '\(' '(^|\h)\K%?%sh\(' '\)' ref sh
# add-highlighter shared/kakrc/shell3 region -recurse '\[' '(^|\h)\K%?%sh\[' '\]' ref sh
# add-highlighter shared/kakrc/shell4 region -recurse '<'  '(^|\h)\K%?%sh<'  '>'  ref sh
# add-highlighter shared/kakrc/shell5 region -recurse '\{' '(^|\h)\K-?shell-script-(completion|candidates)\h+%\{' '\}' ref sh
# add-highlighter shared/kakrc/shell6 region -recurse '\(' '(^|\h)\K-?shell-script-(completion|candidates)\h+%\(' '\)' ref sh
# add-highlighter shared/kakrc/shell7 region -recurse '\[' '(^|\h)\K-?shell-script-(completion|candidates)\h+%\[' '\]' ref sh
# add-highlighter shared/kakrc/shell8 region -recurse '<'  '(^|\h)\K-?shell-script-(completion|candidates)\h+%<'  '>'  ref sh
# add-highlighter shared/kakrc/code/colors regex \b(rgb:[0-9a-fA-F]{6}|rgba:[0-9a-fA-F]{8})\b 0:value
# add-highlighter shared/kakrc/code/numbers regex \b\d+\b 0:value
# add-highlighter shared/kakrc/double_string/fill fill string
# add-highlighter shared/kakrc/double_string/escape regex '""' 0:default+b
# add-highlighter shared/kakrc/single_string/fill fill string
# add-highlighter shared/kakrc/single_string/escape regex "''" 0:default+b
#===============
# Kakoune
# https://kakoune.org

# kakoune-kakoune
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Comment toggling
# - Indentation rules
# Installation
# Alternatively, add comment.kak and indent.kak to your autoload directory.
# This [Kakoune] extension provides support for the [Kakoune] programming language.

# [Kakoune]: https://kakoune.org
# [Kakoune]: https://kakoune.org

## Features

# - Syntax highlighting
# - Auto-indentation

# Configuration ────────────────────────────────────────────────────────────────

# Word pattern
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#word-pattern
declare-option -docstring 'Kakoune word pattern' str kakrc_word_pattern '\w+[?!]?'

# Reference
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://kakrc-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://kakrc-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
#
# class Person
# end
#
# private class Person
# end
#
# abstract class Person
# end
#
# private abstract class Person
# end
#
# def name
# end
#
# private def name
# end
#
# protected def name
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module JSON
# end
#
# private module JSON
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/structs.html
#
# struct Point
# end
#
# private struct Point
# end
#
# abstract struct Point
# end
#
# private abstract struct Point
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://kakrc-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://kakrc-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end

# Detection ────────────────────────────────────────────────────────────────────

# Sets Kakoune filetype when opening `.cr` files.
remove-hooks global kakrc-detection
hook -group kakrc-detection global BufCreate '.+/kakrc|.+\.kak' %{
  set-option buffer filetype kakrc
}

# Enables syntax highlighting for Kakoune filetype.
remove-hooks global kakrc-highlight
hook -group kakrc-highlight global WinSetOption filetype=kakrc %{
  add-highlighter window/kakrc ref kakrc
  hook -always -once window WinSetOption 'filetype=.*' %{
    remove-highlighter window/kakrc
  }
}

# Configures word selection and completion for Kakoune filetype.
# `static_words` option is generated with `kakrc-check-news`.
remove-hooks global kakrc-config
hook -group kakrc-config global WinSetOption filetype=kakrc %{
  set-option window increase_indent_pattern '^\h*(if|elsif|else|unless|case|when|case|in|while|until|class|private\h+class|abstract\h+class|private\h+abstract\h+class|def|private\h+def|protected\h+def|module|private\h+module|struct|private\h+struct|abstract\h+struct|private\h+abstract\h+struct|enum|private\h+enum|begin|rescue|ensure|macro|annotation|lib|private\h+lib)[^;]*$|\h(do)[^;]*$|\w+\h*=\h*(if|unless|case|begin)[^;]*$'
  set-option window decrease_indent_pattern '^\h*(elsif|else|end|when|in|rescue|ensure)$'
  set-option window ignore_indent_pattern '^\h*#'
  set-option window line_comment_token '#'
  set-option buffer extra_word_chars '_' '?' '!'
  set-option window static_words 'add-highlighter' 'addhl' 'alias' 'arrange-buffer' 'buffer' 'b' 'buffer-next' 'bn' 'buffer-previous' 'bp' 'catch' 'change-directory' 'cd' 'colorscheme' 'debug' 'declare-option' 'decl' 'declare-user-mode' 'define-command' 'def' 'complete-command' 'compl' 'delete-buffer' 'db' 'db!' 'delete-buffer!' 'echo' 'edit' 'e' 'e!' 'edit!' 'enter-user-mode' 'evaluate-commands' 'eval' 'execute-keys' 'exec' 'fail' 'hook' 'info' 'kill' 'kill!' 'map' 'menu' 'nop' 'on-key' 'prompt' 'provide-module' 'quit' 'quit!' 'remove-highlighter' 'rmhl' 'remove-hooks' 'rmhooks' 'rename-buffer' 'rename-client' 'rename-session' 'require-module' 'select' 'face' 'set-face' 'set' 'set-option' 'set-register' 'source' 'trigger-user-hook' 'try' 'unalias' 'unmap' 'unset-face' 'set-option' 'update-option' 'write' 'w' 'w!' 'wq' 'wq!' 'write!' 'write-all' 'wa' 'waq' 'write-all-quit' 'write-quit' 'write-quit!' 'global' 'buffer' 'window' 'shared' 'current' 'normal' 'insert' 'menu' 'prompt' 'goto' 'view' 'user' 'object' 'number-lines' 'show-matching' 'show-whitespaces' 'fill' 'regex' 'dynregex' 'group' 'flag-lines' 'ranges' 'line' 'column' 'wrap' 'ref' 'regions' 'region' 'default-region' 'replace-ranges' 'int' 'bool' 'int-list' 'str-list' 'completions' 'line-specs' 'ranges-specs' 'str-to-str-map' '-hidden' '-docstring' '-buffer-completion' '-client-completion' '-shell-completion' '-file-completion' '-command-completion' '-menu' '-params' '-shell-script-candidates' '-shell-script-completion' '-draft' '-itersel' '-quoting' '-to-file' '-to-shell-script' '-markup' '-debug' '-existing' '-fifo' '-readonly' '-verbatim' '-scroll' '-override' '-save-regs' '-always' '-once' '-group' '-end-of-line' '%arg' '%file' '%opt' '%val' '%sh' 'rgb' 'rgba' 'shell' 'raw' 'kakrc' 'default' 'black' 'red' 'green' 'yellow' 'blue' 'magenta' 'cyan' 'white' 'bright-black' 'bright-red' 'bright-green' 'bright-yellow' 'bright-blue' 'bright-magenta' 'bright-cyan' 'bright-white' 'yes' 'no' 'false' 'true' '<semicolon>' '<ret>' '<esc>' '<down>' '<up>' '<left>' '<right>' '<pageup>' '<pagedown>' '<gt>' '<lt>' '<tab>' '<backspace>' '<space>' '<home>' '<end>' '<ins>' '<del>' '<plus>' '<minus>' '<percent>' '<focus_in>' '<focus_out>'
  hook -always -once window WinSetOption 'filetype=.*' %{
    unset-option window line_comment_token
    unset-option buffer extra_word_chars
    unset-option window static_words
  }
}

# Indentation ──────────────────────────────────────────────────────────────────

# Highlighters ─────────────────────────────────────────────────────────────────

# Creates the base regions
add-highlighter shared/kakrc regions
add-highlighter shared/kakrc/code default-region group

# Syntax and semantics ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Classes
# Comments
# Constants
# Entities
# Functions/Methods
# Keywords
# Language Built-ins
# Punctuation
# Storage
# Strings
# Variables

# Scope Naming
# Naming conventions
# Sublime Text
# TextMate
# https://docs.helix-editor.com/themes.html#syntax-highlighting
# https://macromates.com/manual/en/language_grammars
# https://github.com/kakrc-lang-tools/vscode-kakrc-lang/blob/master/syntaxes/kakrc.json
# https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide
# https://sublimetext.com/docs/scope_naming.html

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/

# Method definition and call ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/method_arguments.html

add-highlighter shared/kakrc/code/instance-method-definition regex "\b(def)\h+(%opt{kakrc_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/kakrc/code/class-method-definition regex "\b(def)\h+(self\.%opt{kakrc_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/kakrc/code/method-call regex "\b(%opt{kakrc_word_pattern})\(" 1:function

# Instance and class variables ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://kakrc-lang.org/reference/master/syntax_and_semantics/class_variables.html

add-highlighter shared/kakrc/code/instance-and-class-variables regex '@@?\w+\b' 0:variable

# Keywords ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `kakrc-check-news`.
add-highlighter shared/kakrc/code/keyword regex '\badd-highlighter\b|\baddhl\b|\balias\b|\barrange-buffer\b|\bbuffer\b|\bb\b|\bbuffer-next\b|\bbn\b|\bbuffer-previous\b|\bbp\b|\bcatch\b|\bchange-directory\b|\bcd\b|\bcolorscheme\b|\bdebug\b|\bdeclare-option\b|\bdecl\b|\bdeclare-user-mode\b|\bdefine-command\b|\bdef\b|\bcomplete-command\b|\bcompl\b|\bdelete-buffer\b|\bdb\b|\bdb!\b|\bdelete-buffer!\b|\becho\b|\bedit\b|\be\b|\be!\b|\bedit!\b|\benter-user-mode\b|\bevaluate-commands\b|\beval\b|\bexecute-keys\b|\bexec\b|\bfail\b|\bhook\b|\binfo\b|\bkill\b|\bkill!\b|\bmap\b|\bmenu\b|\bnop\b|\bon-key\b|\bprompt\b|\bprovide-module\b|\bquit\b|\bquit!\b|\bremove-highlighter\b|\brmhl\b|\bremove-hooks\b|\brmhooks\b|\brename-buffer\b|\brename-client\b|\brename-session\b|\brequire-module\b|\bselect\b|\bface\b|\bset-face\b|\bset\b|\bset-option\b|\bset-register\b|\bsource\b|\btrigger-user-hook\b|\btry\b|\bunalias\b|\bunmap\b|\bunset-face\b|\bset-option\b|\bupdate-option\b|\bwrite\b|\bw\b|\bw!\b|\bwq\b|\bwq!\b|\bwrite!\b|\bwrite-all\b|\bwa\b|\bwaq\b|\bwrite-all-quit\b|\bwrite-quit\b|\bwrite-quit!\b' 0:keyword
add-highlighter shared/kakrc/code/attribute regex '\bglobal\b|\bbuffer\b|\bwindow\b|\bshared\b|\bcurrent\b|\bnormal\b|\binsert\b|\bmenu\b|\bprompt\b|\bgoto\b|\bview\b|\buser\b|\bobject\b|\bnumber-lines\b|\bshow-matching\b|\bshow-whitespaces\b|\bfill\b|\bregex\b|\bdynregex\b|\bgroup\b|\bflag-lines\b|\branges\b|\bline\b|\bcolumn\b|\bwrap\b|\bref\b|\bregions\b|\bregion\b|\bdefault-region\b|\breplace-ranges\b|\b-hidden\b|\b-docstring\b|\b-buffer-completion\b|\b-client-completion\b|\b-shell-completion\b|\b-file-completion\b|\b-command-completion\b|\b-menu\b|\b-params\b|\b-shell-script-candidates\b|\b-shell-script-completion\b|\b-draft\b|\b-itersel\b|\b-quoting\b|\b-to-file\b|\b-to-shell-script\b|\b-markup\b|\b-debug\b|\b-existing\b|\b-fifo\b|\b-readonly\b|\b-verbatim\b|\b-scroll\b|\b-override\b|\b-save-regs\b|\b-always\b|\b-once\b|\b-group\b|\b-end-of-line\b' 0:attribute
add-highlighter shared/kakrc/code/type regex '\bint\b|\bbool\b|\bint-list\b|\bstr-list\b|\bcompletions\b|\bline-specs\b|\branges-specs\b|\bstr-to-str-map\b' 0:type
add-highlighter shared/kakrc/code/value regex '\brgb\b|\brgba\b|\bshell\b|\braw\b|\bkakrc\b|\bdefault\b|\bblack\b|\bred\b|\bgreen\b|\byellow\b|\bblue\b|\bmagenta\b|\bcyan\b|\bwhite\b|\bbright-black\b|\bbright-red\b|\bbright-green\b|\bbright-yellow\b|\bbright-blue\b|\bbright-magenta\b|\bbright-cyan\b|\bbright-white\b|\byes\b|\bno\b|\bfalse\b|\btrue\b|\b<semicolon>\b|\b<ret>\b|\b<esc>\b|\b<down>\b|\b<up>\b|\b<left>\b|\b<right>\b|\b<pageup>\b|\b<pagedown>\b|\b<gt>\b|\b<lt>\b|\b<tab>\b|\b<backspace>\b|\b<space>\b|\b<home>\b|\b<end>\b|\b<ins>\b|\b<del>\b|\b<plus>\b|\b<minus>\b|\b<percent>\b|\b<focus_in>\b|\b<focus_out>\b' 0:value
add-highlighter shared/kakrc/code/meta regex '%arg|%file|%opt|%val|%sh' 0:meta

# Built-in functions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `kakrc-check-news`.
add-highlighter shared/kakrc/code/support.function.kernel regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b' 0:builtin
add-highlighter shared/kakrc/code/support.function.object regex '\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Punctuation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# punctuation.separator
add-highlighter shared/kakrc/code/punctuation.separator regex '\.|::' 0:meta

# Operators ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/operators.html

add-highlighter shared/kakrc/code/operator regex '[!%&*+/<=>^|~-]' 0:operator
add-highlighter shared/kakrc/code/operator.range regex '\.\.\.?' 0:operator

# Constants ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/constants.html

add-highlighter shared/kakrc/code/variable.constant regex '\b[A-Z]\w*\b' 0:value

# Numbers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/floats.html

# Examples:
#
# decimal number ⇒ 1_000_000
# float number ⇒ 1_000_000.111_111
#
add-highlighter shared/kakrc/code/constant.numeric.integer.decimal regex '\b\d(_?\d+)*(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/kakrc/code/constant.numeric.float.decimal regex '\b\d(_?\d+)*\.\d(_?\d+)*(_(f32|f64))?\b' 0:value

# Examples:
#
# binary number ⇒ 0b1101
# octal number ⇒ 0o123
# hexadecimal number ⇒ 0xfe012d
#
add-highlighter shared/kakrc/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/kakrc/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/kakrc/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/comments.html

# Note: Avoid string literals with interpolation.
#
# Example:
#
# puts "hello #{name}"
#
add-highlighter shared/kakrc/comment region '#(?!\{)' '$' group
add-highlighter shared/kakrc/comment/fill fill comment

# Documenting code ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/documenting_code.html

# Example:
#
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
#
add-highlighter shared/kakrc/comment/reference regex "`[#.]?%opt{kakrc_word_pattern}`" 0:mono
add-highlighter shared/kakrc/comment/parameter regex '\*\w+\*' 0:mono
add-highlighter shared/kakrc/comment/code-block regex '```(\h*\w+)?$' 0:block
add-highlighter shared/kakrc/comment/admonition regex '\h+([A-Z]+):\h+' 1:meta
add-highlighter shared/kakrc/comment/directive regex ':\w+:' 0:meta

# Interpolation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping

# Defines Kakoune raw string.
#
# Syntax:
#
# define-kakrc-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-kakrc-string raw-parenthesis-string string -recurse '\(' '%q\(' '\)'
#
# puts %q(hello world)
#
declare-option -hidden str-list kakrc_optional_arguments
define-command -hidden define-kakrc-string -params 4.. %{
  set-option global kakrc_optional_arguments %arg{@}
  set-option -remove global kakrc_optional_arguments %arg{1} %arg{2}
  add-highlighter "shared/kakrc/%arg{1}" region %opt{kakrc_optional_arguments} regions
  add-highlighter "shared/kakrc/%arg{1}/content" default-region group
  add-highlighter "shared/kakrc/%arg{1}/content/fill" fill %arg{2}
  add-highlighter "shared/kakrc/%arg{1}/content/escaped-character" regex '\\.' 0:meta
  add-highlighter "shared/kakrc/%arg{1}/content/escape-sequence" regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
}

# Defines Kakoune string interpolation.
#
# Syntax:
#
# define-kakrc-interpolated-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-kakrc-interpolated-string parenthesis-string string -recurse '\(' '%\(' '\)'
#
# name = "world"
# puts %(hello #{name})
#
define-command -hidden define-kakrc-interpolated-string -params 4.. %{
  define-kakrc-string %arg{@}
  add-highlighter "shared/kakrc/%arg{1}/interpolation" region -recurse '\{' '#\{' '\}' group # }
  add-highlighter "shared/kakrc/%arg{1}/interpolation/delimiters" regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
  add-highlighter "shared/kakrc/%arg{1}/interpolation/kakrc" ref kakrc
}

# Characters ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/char.html

# Examples:
#
# simple character ⇒ 'a'
# single quote ⇒ '\''
# backslash ⇒ '\\'
#
add-highlighter shared/kakrc/string region "'" "(?<!\\)(\\\\)*'" regions
add-highlighter shared/kakrc/string/content default-region group
add-highlighter shared/kakrc/string/content/fill fill value
add-highlighter shared/kakrc/string/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/kakrc/string/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
# define-kakrc-string string.character value "'" "(?<!\\)(\\\\)*'"

# Strings ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/string.html

# String literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Examples:
#
# simple string ⇒ "hello world"
# double quote ⇒ "\""
# backslash ⇒ "\\"
#
add-highlighter shared/kakrc/string.interpolated region '"' '(?<!\\)(\\\\)*"' regions
add-highlighter shared/kakrc/string.interpolated/content default-region group
add-highlighter shared/kakrc/string.interpolated/content/fill fill string
add-highlighter shared/kakrc/string.interpolated/content/escaped-character ref kakrc/string/content/escaped-character
add-highlighter shared/kakrc/string.interpolated/content/escape-sequence ref kakrc/string/content/escape-sequence
add-highlighter shared/kakrc/string.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/kakrc/string.interpolated/interpolation/delimiters regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
add-highlighter shared/kakrc/string.interpolated/interpolation/kakrc ref kakrc
# define-kakrc-interpolated-string string.quoted.double string '"' '(?<!\\)(\\\\)*"'

# Percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals

# Example:
#
# name = "world"
# puts %Q(hello #{name})
#
add-highlighter shared/kakrc/string.quoted.percent.parenthesis.interpolated region -recurse '\(' '%Q?\(' '\)' ref kakrc/string.interpolated
add-highlighter shared/kakrc/string.quoted.percent.bracket.interpolated region -recurse '\[' '%Q?\[' '\]' ref kakrc/string.interpolated
add-highlighter shared/kakrc/string.quoted.percent.brace.interpolated region -recurse '\{' '%Q?\{' '\}' ref kakrc/string.interpolated
add-highlighter shared/kakrc/string.quoted.percent.angle.interpolated region -recurse '<' '%Q?<' '>' ref kakrc/string.interpolated
add-highlighter shared/kakrc/string.quoted.percent.pipe.interpolated region '%Q?\|' '\|' ref kakrc/string.interpolated

# Raw percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal

# Example:
#
# puts %q(hello world)
#
add-highlighter shared/kakrc/string.quoted.percent.parenthesis region -recurse '\(' '%[qwi]\(' '\)' ref kakrc/string
add-highlighter shared/kakrc/string.quoted.percent.bracket region -recurse '\[' '%[qwi]\[' '\]' ref kakrc/string
add-highlighter shared/kakrc/string.quoted.percent.brace region -recurse '\{' '%[qwi]\{' '\}' ref kakrc/string
add-highlighter shared/kakrc/string.quoted.percent.angle region -recurse '<' '%[qwi]<' '>' ref kakrc/string
add-highlighter shared/kakrc/string.quoted.percent.pipe region '%[qwi]\|' '\|' ref kakrc/string

# Here document ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc

# Example:
#
# <<-'EOF'
# EOF
#
add-highlighter shared/kakrc/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref kakrc/string.interpolated
add-highlighter shared/kakrc/string.unquoted.heredoc.raw region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' ref kakrc/string

# Symbols ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/symbol.html

# Symbol literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# :"quoted symbol"
#
add-highlighter shared/kakrc/code/constant.symbol regex ":%opt{kakrc_word_pattern}" 0:value
add-highlighter shared/kakrc/string.symbol region ':"' '(?<!\\)(\\\\)*"' ref kakrc/string

# Regular expressions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/regex.html

# Regex literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# /foo/i.match("FOO")
#
add-highlighter shared/kakrc/string.regexp.interpolated region '/' '(?<!\\)(\\\\)*/[imx]*' regions
add-highlighter shared/kakrc/string.regexp.interpolated/content default-region group
add-highlighter shared/kakrc/string.regexp.interpolated/content/fill fill meta
add-highlighter shared/kakrc/string.regexp.interpolated/content/escaped-character ref kakrc/string/content/escaped-character
add-highlighter shared/kakrc/string.regexp.interpolated/content/escape-sequence ref kakrc/string/content/escape-sequence
add-highlighter shared/kakrc/string.regexp.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/kakrc/string.regexp.interpolated/interpolation/delimiters ref kakrc/string.interpolated/interpolation/delimiters
add-highlighter shared/kakrc/string.regexp.interpolated/interpolation/kakrc ref kakrc

# Note: Avoid unterminated regular expression and floor division as regex.
#
# Examples:
#
# division ⇒ 1 / 2
# floor division ⇒ 1 // 2
#
add-highlighter shared/kakrc/division-as-region region ' //? ' '.\K' group
add-highlighter shared/kakrc/division-as-region/operator regex '//?' 0:operator

# Percent regex literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %r(foo|bar)
#
add-highlighter shared/kakrc/string.regexp.percent.parenthesis.interpolated region -recurse '\(' '%r\(' '\)[imx]*' ref kakrc/string.regexp.interpolated
add-highlighter shared/kakrc/string.regexp.percent.bracket.interpolated region -recurse '\[' '%r\[' '\][imx]*' ref kakrc/string.regexp.interpolated
add-highlighter shared/kakrc/string.regexp.percent.brace.interpolated region -recurse '\{' '%r\{' '\}[imx]*' ref kakrc/string.regexp.interpolated
add-highlighter shared/kakrc/string.regexp.percent.angle.interpolated region -recurse '<' '%r<' '>[imx]*' ref kakrc/string.regexp.interpolated
add-highlighter shared/kakrc/string.regexp.percent.pipe.interpolated region '%r\|' '\|[imx]*' ref kakrc/string.regexp.interpolated

# Command literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://kakrc-lang.org/reference/master/syntax_and_semantics/literals/command.html

# Example:
#
# `echo foo`
#
add-highlighter shared/kakrc/string.command region '`' '(?<!\\)(\\\\)*`' ref kakrc/string.regexp.interpolated

# Percent command literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %x(echo foo)
#
add-highlighter shared/kakrc/string.command.percent.parenthesis region -recurse '\(' '%x\(' '\)' ref kakrc/string.regexp.interpolated
add-highlighter shared/kakrc/string.command.percent.bracket region -recurse '\[' '%x\[' '\]' ref kakrc/string.regexp.interpolated
add-highlighter shared/kakrc/string.command.percent.brace region -recurse '\{' '%x\{' '\}' ref kakrc/string.regexp.interpolated
add-highlighter shared/kakrc/string.command.percent.angle region -recurse '<' '%x<' '>' ref kakrc/string.regexp.interpolated
add-highlighter shared/kakrc/string.command.percent.pipe region '%x\|' '\|' ref kakrc/string.regexp.interpolated

# What’s new ───────────────────────────────────────────────────────────────────

# Builds a ready for use `str-list` and `regex` with selections.
#
# Usage:
#
# Fetch a document, select keywords and call `kakrc-build-result keywords`.
#
define-command -hidden kakrc-build-result -params 1 %{
  # Initialization
  execute-keys -save-regs '' 'y'
  edit -scratch

  execute-keys '%<a-R>a<ret><esc>y%<a-R>%|sort -u<ret><a-s>_'
  echo -debug kakrc %arg{1} as str-list:
  echo -debug -quoting kakrc %val{selections}

  execute-keys '%|awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>_'
  execute-keys -save-regs '' '*'
  echo -debug kakrc %arg{1} as regex:
  echo -debug -quoting kakrc %val{main_reg_slash}

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}

define-command -hidden kakrc-build-result-with-static-words -params 1 %{
  kakrc-build-result %arg{1}
  set-option -add window static_words %val{selections}
}

define-command -hidden kakrc-check-news %{
  # Initialization
  edit -scratch
  set-option window static_words

  # Keywords ⇒ https://github.com/kakrc-lang/kakrc/blob/master/src/compiler/kakrc/syntax/lexer.cr
  execute-keys '%|curl -sSL https://github.com/kakrc-lang/kakrc/raw/master/src/compiler/kakrc/syntax/lexer.cr<ret>'
  execute-keys '%1<s>check_ident_or_keyword\(:(%opt{kakrc_word_pattern}<a-!>),\h+\w+\)<ret>Z%1<s>@token\.value\h+=\h+:(%opt{kakrc_word_pattern}<a-!>)<ret><a-z>a'
  kakrc-build-result-with-static-words keywords

  # Top Level Namespace
  # https://kakrc-lang.org/api/master/toplevel.html#method-summary
  # https://kakrc-lang.org/api/master/toplevel.html#macro-summary
  execute-keys '%|curl -sSL https://kakrc-lang.org/api/master/toplevel.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{kakrc_word_pattern}<a-!>)[^"]*-(method|macro)"<ret>'
  kakrc-build-result-with-static-words top-level-namespace

  # Object macros ⇒ https://kakrc-lang.org/api/master/Object.html#macro-summary
  execute-keys '%|curl -sSL https://kakrc-lang.org/api/master/Object.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{kakrc_word_pattern}<a-!>)[^"]*-(macro)"<ret>'
  kakrc-build-result-with-static-words object-macros

  # Static words
  set-register dquote %opt{static_words}
  execute-keys '%<a-R>'
  kakrc-build-result static_words

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}
