#===============
hook global BufCreate .*\.((z|ba|c|k|mk)?sh(rc|_profile)?|profile) %{
    set-option buffer filetype sh
}

hook global WinSetOption filetype=sh %{
    require-module sh
    set-option window static_words %opt{sh_static_words}

    hook window ModeChange pop:insert:.* -group sh-trim-indent sh-trim-indent
    hook window InsertChar \n -group sh-insert sh-insert-on-new-line
    hook window InsertChar \n -group sh-indent sh-indent-on-new-line
    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window sh-.+ }
}

hook -group sh-highlight global WinSetOption filetype=sh %{
    add-highlighter window/sh ref sh
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/sh }
}

# using non-ascii characters here so that we can use the '[' command
provide-module sh %§

add-highlighter shared/sh regions
add-highlighter shared/sh/code default-region group
add-highlighter shared/sh/arithmetic region -recurse \(.*?\( (\$|(?<=for)\h*)\(\( \)\) group
add-highlighter shared/sh/double_string region  %{(?<!\\)(?:\\\\)*\K"} %{(?<!\\)(?:\\\\)*"} group
add-highlighter shared/sh/single_string region %{(?<!\\)(?:\\\\)*\K'} %{'} fill string
add-highlighter shared/sh/expansion region -recurse (?<!\\)(?:\\\\)*\K\$\{ (?<!\\)(?:\\\\)*\K\$\{ \}|\n fill value
add-highlighter shared/sh/comment region (?<!\\)(?:\\\\)*(?:^|\h)\K# '$' fill comment
add-highlighter shared/sh/heredoc region -match-capture '<<-?\h*''?(\w+)''?' '^\t*(\w+)$' fill string

add-highlighter shared/sh/arithmetic/expansion ref sh/double_string/expansion
add-highlighter shared/sh/double_string/fill fill string

evaluate-commands %sh{
    # Grammar
    # Generated with `compgen -k` in bash
    keywords="if then else elif fi case esac for select while until do done in
             function time coproc"

    # Generated with `compgen -b` in bash
    builtins="alias bg bind break builtin caller cd command compgen complete
             compopt continue declare dirs disown echo enable eval exec
             exit export false fc fg getopts hash help history jobs kill
             let local logout mapfile popd printf pushd pwd read readarray
             readonly return set shift shopt source suspend test times trap
             true type typeset ulimit umask unalias unset wait"

    join() { sep=$2; eval set -- $1; IFS="$sep"; echo "$*"; }

    # Add the language's grammar to the static completion list
    printf %s\\n "declare-option str-list sh_static_words $(join "${keywords}" ' ') $(join "${builtins}" ' ')"

    # Highlight keywords
    printf %s\\n "add-highlighter shared/sh/code/ regex (?<!-)\b($(join "${keywords}" '|'))\b(?!-) 0:keyword"

    # Highlight builtins
    printf %s "add-highlighter shared/sh/code/builtin regex (?<!-)\b($(join "${builtins}" '|'))\b(?!-) 0:builtin"
}

add-highlighter shared/sh/code/operators regex [\[\]\(\)&|]{1,2} 0:operator
add-highlighter shared/sh/code/variable regex ((?<![-:])\b\w+)= 1:variable
add-highlighter shared/sh/code/alias regex \balias(\h+[-+]\w)*\h+([\w-.]+)= 2:variable
add-highlighter shared/sh/code/function regex ^\h*(\S+(?<!=))\h*\(\) 1:function

add-highlighter shared/sh/code/unscoped_expansion regex (?<!\\)(?:\\\\)*\K\$(\w+|#|@|\?|\$|!|-|\*) 0:value
add-highlighter shared/sh/double_string/expansion regex (?<!\\)(?:\\\\)*\K\$(\w+|#|@|\?|\$|!|-|\*|\{.+?\}) 0:value

# Commands
# ‾‾‾‾‾‾‾‾

define-command -hidden sh-trim-indent %{
    # remove trailing white spaces
    try %{ execute-keys -draft -itersel x s \h+$ <ret> d }
}

# This is at best an approximation, since shell syntax is very complex.
# Also note that this targets plain sh syntax, not bash - bash adds a whole
# other level of complexity. If your bash code is fairly portable this will
# probably work.
#
# Of necessity, this is also fairly opinionated about indentation styles.
# Doing it "properly" would require far more context awareness than we can
# bring to this kind of thing.
define-command -hidden sh-insert-on-new-line %[
    evaluate-commands -draft -itersel %[
        # copy '#' comment prefix and following white spaces
        try %{ execute-keys -draft k x s ^\h*\K#\h* <ret> y gh j P }
    ]
]

# Use custom object matching to copy indentation for the various logical
# blocks.
#
# Note that we're using a weird non-ascii character instead of [ or { here
# because the '[' and '{' characters need to be available for the commands.
define-command -hidden sh-indent-on-new-line %¶
    evaluate-commands -draft -itersel %@
        # preserve previous line indent
        try %{ execute-keys -draft <semicolon> K <a-&> }
        # filter previous line
        try %{ execute-keys -draft k : sh-trim-indent <ret> }

        # Indent loop syntax, e.g.:
        # for foo in bar; do
        #       things
        # done
        #
        # or:
        #
        # while foo; do
        #       things
        # done
        #
        # or equivalently:
        #
        # while foo
        # do
        #       things
        # done
        #
        # indent after do
        try %{ execute-keys -draft , k x <a-k> \bdo$ <ret> j <a-gt> }
        # copy the indentation of the matching for/when - matching on the do
        # statement, so we don't need to duplicate this for the two loop
        # structures.
        try %{ execute-keys -draft , k x <a-k> \bdone$ <ret> gh [c\bdo\b,\bdone\b <ret> x <a-S> 1<a-&> , j K <a-&> }

        # Indent if/then/else syntax, e.g.:
        # if [ $foo = $bar ]; then
        #       things
        # else
        #       other_things
        # fi
        #
        # or equivalently:
        # if [ $foo = $bar ]
        # then
        #       things
        # else
        #       other_things
        # fi
        #
        # indent after then
        try %{ execute-keys -draft , k x <a-k> \bthen$ <ret> j <a-gt> }
        # copy the indentation of the matching if
        try %{ execute-keys -draft , k x <a-k> \bfi$ <ret> gh [c\bif\b,\bfi\b <ret> x <a-S> 1<a-&> , j K <a-&> }
        # copy the indentation of the matching if, and then re-indent afterwards
        try %{ execute-keys -draft , k x <a-k> \belse$ <ret> gh [c\bif\b,\bfi\b <ret> x <a-S> 1<a-&> , j K <a-&> j <a-gt> }

        # Indent case syntax, e.g.:
        # case "$foo" in
        #       bar) thing1;;
        #       baz)
        #               things
        #               ;;
        #       *)
        #               default_things
        #               ;;
        # esac
        #
        # or equivalently:
        # case "$foo"
        # in
        #       bar) thing1;;
        # esac
        #
        # indent after in
        try %{ execute-keys -draft , k x <a-k> \bin$ <ret> j <a-gt> }
        # copy the indentation of the matching case
        try %{ execute-keys -draft , k x <a-k> \besac$ <ret> gh [c\bcase\b,\besac\b <ret> x <a-S> 1<a-&> , j K <a-&> }
        # indent after )
        try %{ execute-keys -draft , k x <a-k> ^\s*\(?[^(]+[^)]\)$ <ret> j <a-gt> }
        # deindent after ;;
        try %{ execute-keys -draft , k x <a-k> ^\s*\;\;$ <ret> j <a-lt> }

        # Indent compound commands as logical blocks, e.g.:
        # {
        #       thing1
        #       thing2
        # }
        #
        # or in a function definition:
        # foo () {
        #       thing1
        #       thing2
        # }
        #
        # We don't handle () delimited compond commands - these are technically very
        # similar, but the use cases are quite different and much less common.
        #
        # Note that in this context the '{' and '}' characters are reserved
        # words, and hence must be surrounded by a token separator - typically
        # white space (including a newline), though technically it can also be
        # ';'. Only vertical white space makes sense in this context, though,
        # since the syntax denotes a logical block, not a simple compound command.
        try %= execute-keys -draft , k x <a-k> (\s|^)\{$ <ret> j <a-gt> =
        # deindent closing }
        try %= execute-keys -draft , k x <a-k> ^\s*\}$ <ret> <a-lt> j K <a-&> =
        # deindent closing } when after cursor
        try %= execute-keys -draft x <a-k> ^\h*\} <ret> gh / \} <ret> m <a-S> 1<a-&> =

    @
¶

§
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
# Shell
# https://shell.org

# shell-shell
# This Shell extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Comment toggling
# - Indentation rules
# Installation
# Alternatively, add comment.kak and indent.kak to your autoload directory.
# This [Shell] extension provides support for the [Shell] programming language.

# [Shell]: https://shell.org
# [Shell]: https://shell.org

## Features

# - Syntax highlighting
# - Auto-indentation

# Configuration ────────────────────────────────────────────────────────────────

# Word pattern
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#word-pattern
declare-option -docstring 'Shell word pattern' str shell_word_pattern '\w+[?!]?'

# Reference
#
# https://shell-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://shell-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://shell-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://shell-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://shell-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://shell-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://shell-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://shell-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://shell-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://shell-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
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
# https://shell-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module JSON
# end
#
# private module JSON
# end
#
# https://shell-lang.org/reference/master/syntax_and_semantics/structs.html
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
# https://shell-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://shell-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://shell-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://shell-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://shell-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://shell-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://shell-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end

# Detection ────────────────────────────────────────────────────────────────────

# Sets Shell filetype when opening `.cr` files.
remove-hooks global shell-detection
hook -group shell-detection global BufCreate '.+\.sh' %{
  set-option buffer filetype shell
}

# Enables syntax highlighting for Shell filetype.
remove-hooks global shell-highlight
hook -group shell-highlight global WinSetOption filetype=shell %{
  add-highlighter window/shell ref shell
  hook -always -once window WinSetOption 'filetype=.*' %{
    remove-highlighter window/shell
  }
}

# Configures word selection and completion for Shell filetype.
# `static_words` option is generated with `shell-check-news`.
remove-hooks global shell-config
hook -group shell-config global WinSetOption filetype=shell %{
  set-option window increase_indent_pattern '^\h*(if|elsif|else|unless|case|when|case|in|while|until|class|private\h+class|abstract\h+class|private\h+abstract\h+class|def|private\h+def|protected\h+def|module|private\h+module|struct|private\h+struct|abstract\h+struct|private\h+abstract\h+struct|enum|private\h+enum|begin|rescue|ensure|macro|annotation|lib|private\h+lib)[^;]*$|\h(do)[^;]*$|\w+\h*=\h*(if|unless|case|begin)[^;]*$'
  set-option window decrease_indent_pattern '^\h*(elsif|else|end|when|in|rescue|ensure)$'
  set-option window ignore_indent_pattern '^\h*#'
  set-option window line_comment_token '#'
  set-option buffer extra_word_chars '_' '?' '!'
  set-option window static_words 'add-highlighter' 'addhl' 'alias' 'arrange-buffer' 'buffer' 'b' 'buffer-next' 'bn' 'buffer-previous' 'bp' 'catch' 'change-directory' 'cd' 'colorscheme' 'debug' 'declare-option' 'decl' 'declare-user-mode' 'define-command' 'def' 'complete-command' 'compl' 'delete-buffer' 'db' 'db!' 'delete-buffer!' 'echo' 'edit' 'e' 'e!' 'edit!' 'enter-user-mode' 'evaluate-commands' 'eval' 'execute-keys' 'exec' 'fail' 'hook' 'info' 'kill' 'kill!' 'map' 'menu' 'nop' 'on-key' 'prompt' 'provide-module' 'quit' 'quit!' 'remove-highlighter' 'rmhl' 'remove-hooks' 'rmhooks' 'rename-buffer' 'rename-client' 'rename-session' 'require-module' 'select' 'face' 'set-face' 'set' 'set-option' 'set-register' 'source' 'trigger-user-hook' 'try' 'unalias' 'unmap' 'unset-face' 'set-option' 'update-option' 'write' 'w' 'w!' 'wq' 'wq!' 'write!' 'write-all' 'wa' 'waq' 'write-all-quit' 'write-quit' 'write-quit!' 'global' 'buffer' 'window' 'shared' 'current' 'normal' 'insert' 'menu' 'prompt' 'goto' 'view' 'user' 'object' 'number-lines' 'show-matching' 'show-whitespaces' 'fill' 'regex' 'dynregex' 'group' 'flag-lines' 'ranges' 'line' 'column' 'wrap' 'ref' 'regions' 'region' 'default-region' 'replace-ranges' 'int' 'bool' 'int-list' 'str-list' 'completions' 'line-specs' 'ranges-specs' 'str-to-str-map' '-hidden' '-docstring' '-buffer-completion' '-client-completion' '-shell-completion' '-file-completion' '-command-completion' '-menu' '-params' '-shell-script-candidates' '-shell-script-completion' '-draft' '-itersel' '-quoting' '-to-file' '-to-shell-script' '-markup' '-debug' '-existing' '-fifo' '-readonly' '-verbatim' '-scroll' '-override' '-save-regs' '-always' '-once' '-group' '-end-of-line' '%arg' '%file' '%opt' '%val' '%sh' 'rgb' 'rgba' 'shell' 'raw' 'shell' 'default' 'black' 'red' 'green' 'yellow' 'blue' 'magenta' 'cyan' 'white' 'bright-black' 'bright-red' 'bright-green' 'bright-yellow' 'bright-blue' 'bright-magenta' 'bright-cyan' 'bright-white' 'yes' 'no' 'false' 'true' '<semicolon>' '<ret>' '<esc>' '<down>' '<up>' '<left>' '<right>' '<pageup>' '<pagedown>' '<gt>' '<lt>' '<tab>' '<backspace>' '<space>' '<home>' '<end>' '<ins>' '<del>' '<plus>' '<minus>' '<percent>' '<focus_in>' '<focus_out>'
  hook -always -once window WinSetOption 'filetype=.*' %{
    unset-option window line_comment_token
    unset-option buffer extra_word_chars
    unset-option window static_words
  }
}

# Indentation ──────────────────────────────────────────────────────────────────

# Highlighters ─────────────────────────────────────────────────────────────────

# Creates the base regions
add-highlighter shared/shell regions
add-highlighter shared/shell/code default-region group

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
# https://github.com/shell-lang-tools/vscode-shell-lang/blob/master/syntaxes/shell.json
# https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide
# https://sublimetext.com/docs/scope_naming.html

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/

# Method definition and call ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/method_arguments.html

add-highlighter shared/shell/code/instance-method-definition regex "\b(def)\h+(%opt{shell_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/shell/code/class-method-definition regex "\b(def)\h+(self\.%opt{shell_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/shell/code/method-call regex "\b(%opt{shell_word_pattern})\(" 1:function

# Instance and class variables ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://shell-lang.org/reference/master/syntax_and_semantics/class_variables.html

add-highlighter shared/shell/code/instance-and-class-variables regex '@@?\w+\b' 0:variable

# Keywords ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `shell-check-news`.
add-highlighter shared/shell/code/keyword regex '\badd-highlighter\b|\baddhl\b|\balias\b|\barrange-buffer\b|\bbuffer\b|\bb\b|\bbuffer-next\b|\bbn\b|\bbuffer-previous\b|\bbp\b|\bcatch\b|\bchange-directory\b|\bcd\b|\bcolorscheme\b|\bdebug\b|\bdeclare-option\b|\bdecl\b|\bdeclare-user-mode\b|\bdefine-command\b|\bdef\b|\bcomplete-command\b|\bcompl\b|\bdelete-buffer\b|\bdb\b|\bdb!\b|\bdelete-buffer!\b|\becho\b|\bedit\b|\be\b|\be!\b|\bedit!\b|\benter-user-mode\b|\bevaluate-commands\b|\beval\b|\bexecute-keys\b|\bexec\b|\bfail\b|\bhook\b|\binfo\b|\bkill\b|\bkill!\b|\bmap\b|\bmenu\b|\bnop\b|\bon-key\b|\bprompt\b|\bprovide-module\b|\bquit\b|\bquit!\b|\bremove-highlighter\b|\brmhl\b|\bremove-hooks\b|\brmhooks\b|\brename-buffer\b|\brename-client\b|\brename-session\b|\brequire-module\b|\bselect\b|\bface\b|\bset-face\b|\bset\b|\bset-option\b|\bset-register\b|\bsource\b|\btrigger-user-hook\b|\btry\b|\bunalias\b|\bunmap\b|\bunset-face\b|\bset-option\b|\bupdate-option\b|\bwrite\b|\bw\b|\bw!\b|\bwq\b|\bwq!\b|\bwrite!\b|\bwrite-all\b|\bwa\b|\bwaq\b|\bwrite-all-quit\b|\bwrite-quit\b|\bwrite-quit!\b' 0:keyword
add-highlighter shared/shell/code/attribute regex '\bglobal\b|\bbuffer\b|\bwindow\b|\bshared\b|\bcurrent\b|\bnormal\b|\binsert\b|\bmenu\b|\bprompt\b|\bgoto\b|\bview\b|\buser\b|\bobject\b|\bnumber-lines\b|\bshow-matching\b|\bshow-whitespaces\b|\bfill\b|\bregex\b|\bdynregex\b|\bgroup\b|\bflag-lines\b|\branges\b|\bline\b|\bcolumn\b|\bwrap\b|\bref\b|\bregions\b|\bregion\b|\bdefault-region\b|\breplace-ranges\b|\b-hidden\b|\b-docstring\b|\b-buffer-completion\b|\b-client-completion\b|\b-shell-completion\b|\b-file-completion\b|\b-command-completion\b|\b-menu\b|\b-params\b|\b-shell-script-candidates\b|\b-shell-script-completion\b|\b-draft\b|\b-itersel\b|\b-quoting\b|\b-to-file\b|\b-to-shell-script\b|\b-markup\b|\b-debug\b|\b-existing\b|\b-fifo\b|\b-readonly\b|\b-verbatim\b|\b-scroll\b|\b-override\b|\b-save-regs\b|\b-always\b|\b-once\b|\b-group\b|\b-end-of-line\b' 0:attribute
add-highlighter shared/shell/code/type regex '\bint\b|\bbool\b|\bint-list\b|\bstr-list\b|\bcompletions\b|\bline-specs\b|\branges-specs\b|\bstr-to-str-map\b' 0:type
add-highlighter shared/shell/code/value regex '\brgb\b|\brgba\b|\bshell\b|\braw\b|\bshell\b|\bdefault\b|\bblack\b|\bred\b|\bgreen\b|\byellow\b|\bblue\b|\bmagenta\b|\bcyan\b|\bwhite\b|\bbright-black\b|\bbright-red\b|\bbright-green\b|\bbright-yellow\b|\bbright-blue\b|\bbright-magenta\b|\bbright-cyan\b|\bbright-white\b|\byes\b|\bno\b|\bfalse\b|\btrue\b|\b<semicolon>\b|\b<ret>\b|\b<esc>\b|\b<down>\b|\b<up>\b|\b<left>\b|\b<right>\b|\b<pageup>\b|\b<pagedown>\b|\b<gt>\b|\b<lt>\b|\b<tab>\b|\b<backspace>\b|\b<space>\b|\b<home>\b|\b<end>\b|\b<ins>\b|\b<del>\b|\b<plus>\b|\b<minus>\b|\b<percent>\b|\b<focus_in>\b|\b<focus_out>\b' 0:value
add-highlighter shared/shell/code/meta regex '%arg|%file|%opt|%val|%sh' 0:meta

# Built-in functions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `shell-check-news`.
add-highlighter shared/shell/code/support.function.kernel regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b' 0:builtin
add-highlighter shared/shell/code/support.function.object regex '\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Punctuation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# punctuation.separator
add-highlighter shared/shell/code/punctuation.separator regex '\.|::' 0:meta

# Operators ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/operators.html

add-highlighter shared/shell/code/operator regex '[!%&*+/<=>^|~-]' 0:operator
add-highlighter shared/shell/code/operator.range regex '\.\.\.?' 0:operator

# Constants ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/constants.html

add-highlighter shared/shell/code/variable.constant regex '\b[A-Z]\w*\b' 0:value

# Numbers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/floats.html

# Examples:
#
# decimal number ⇒ 1_000_000
# float number ⇒ 1_000_000.111_111
#
add-highlighter shared/shell/code/constant.numeric.integer.decimal regex '\b\d(_?\d+)*(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/shell/code/constant.numeric.float.decimal regex '\b\d(_?\d+)*\.\d(_?\d+)*(_(f32|f64))?\b' 0:value

# Examples:
#
# binary number ⇒ 0b1101
# octal number ⇒ 0o123
# hexadecimal number ⇒ 0xfe012d
#
add-highlighter shared/shell/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/shell/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/shell/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/comments.html

# Note: Avoid string literals with interpolation.
#
# Example:
#
# puts "hello #{name}"
#
add-highlighter shared/shell/comment region '#(?!\{)' '$' group
add-highlighter shared/shell/comment/fill fill comment

# Documenting code ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/documenting_code.html

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
add-highlighter shared/shell/comment/reference regex "`[#.]?%opt{shell_word_pattern}`" 0:mono
add-highlighter shared/shell/comment/parameter regex '\*\w+\*' 0:mono
add-highlighter shared/shell/comment/code-block regex '```(\h*\w+)?$' 0:block
add-highlighter shared/shell/comment/admonition regex '\h+([A-Z]+):\h+' 1:meta
add-highlighter shared/shell/comment/directive regex ':\w+:' 0:meta

# Interpolation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping

# Defines Shell raw string.
#
# Syntax:
#
# define-shell-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-shell-string raw-parenthesis-string string -recurse '\(' '%q\(' '\)'
#
# puts %q(hello world)
#
declare-option -hidden str-list shell_optional_arguments
define-command -hidden define-shell-string -params 4.. %{
  set-option global shell_optional_arguments %arg{@}
  set-option -remove global shell_optional_arguments %arg{1} %arg{2}
  add-highlighter "shared/shell/%arg{1}" region %opt{shell_optional_arguments} regions
  add-highlighter "shared/shell/%arg{1}/content" default-region group
  add-highlighter "shared/shell/%arg{1}/content/fill" fill %arg{2}
  add-highlighter "shared/shell/%arg{1}/content/escaped-character" regex '\\.' 0:meta
  add-highlighter "shared/shell/%arg{1}/content/escape-sequence" regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
}

# Defines Shell string interpolation.
#
# Syntax:
#
# define-shell-interpolated-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-shell-interpolated-string parenthesis-string string -recurse '\(' '%\(' '\)'
#
# name = "world"
# puts %(hello #{name})
#
define-command -hidden define-shell-interpolated-string -params 4.. %{
  define-shell-string %arg{@}
  add-highlighter "shared/shell/%arg{1}/interpolation" region -recurse '\{' '#\{' '\}' group # }
  add-highlighter "shared/shell/%arg{1}/interpolation/delimiters" regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
  add-highlighter "shared/shell/%arg{1}/interpolation/shell" ref shell
}

# Characters ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/char.html

# Examples:
#
# simple character ⇒ 'a'
# single quote ⇒ '\''
# backslash ⇒ '\\'
#
add-highlighter shared/shell/string region "'" "(?<!\\)(\\\\)*'" regions
add-highlighter shared/shell/string/content default-region group
add-highlighter shared/shell/string/content/fill fill value
add-highlighter shared/shell/string/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/shell/string/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
# define-shell-string string.character value "'" "(?<!\\)(\\\\)*'"

# Strings ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/string.html

# String literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Examples:
#
# simple string ⇒ "hello world"
# double quote ⇒ "\""
# backslash ⇒ "\\"
#
add-highlighter shared/shell/string.interpolated region '"' '(?<!\\)(\\\\)*"' regions
add-highlighter shared/shell/string.interpolated/content default-region group
add-highlighter shared/shell/string.interpolated/content/fill fill string
add-highlighter shared/shell/string.interpolated/content/escaped-character ref shell/string/content/escaped-character
add-highlighter shared/shell/string.interpolated/content/escape-sequence ref shell/string/content/escape-sequence
add-highlighter shared/shell/string.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/shell/string.interpolated/interpolation/delimiters regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
add-highlighter shared/shell/string.interpolated/interpolation/shell ref shell
# define-shell-interpolated-string string.quoted.double string '"' '(?<!\\)(\\\\)*"'

# Percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals

# Example:
#
# name = "world"
# puts %Q(hello #{name})
#
add-highlighter shared/shell/string.quoted.percent.parenthesis.interpolated region -recurse '\(' '%Q?\(' '\)' ref shell/string.interpolated
add-highlighter shared/shell/string.quoted.percent.bracket.interpolated region -recurse '\[' '%Q?\[' '\]' ref shell/string.interpolated
add-highlighter shared/shell/string.quoted.percent.brace.interpolated region -recurse '\{' '%Q?\{' '\}' ref shell/string.interpolated
add-highlighter shared/shell/string.quoted.percent.angle.interpolated region -recurse '<' '%Q?<' '>' ref shell/string.interpolated
add-highlighter shared/shell/string.quoted.percent.pipe.interpolated region '%Q?\|' '\|' ref shell/string.interpolated

# Raw percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal

# Example:
#
# puts %q(hello world)
#
add-highlighter shared/shell/string.quoted.percent.parenthesis region -recurse '\(' '%[qwi]\(' '\)' ref shell/string
add-highlighter shared/shell/string.quoted.percent.bracket region -recurse '\[' '%[qwi]\[' '\]' ref shell/string
add-highlighter shared/shell/string.quoted.percent.brace region -recurse '\{' '%[qwi]\{' '\}' ref shell/string
add-highlighter shared/shell/string.quoted.percent.angle region -recurse '<' '%[qwi]<' '>' ref shell/string
add-highlighter shared/shell/string.quoted.percent.pipe region '%[qwi]\|' '\|' ref shell/string

# Here document ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc

# Example:
#
# <<-'EOF'
# EOF
#
add-highlighter shared/shell/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref shell/string.interpolated
add-highlighter shared/shell/string.unquoted.heredoc.raw region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' ref shell/string

# Symbols ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/symbol.html

# Symbol literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# :"quoted symbol"
#
add-highlighter shared/shell/code/constant.symbol regex ":%opt{shell_word_pattern}" 0:value
add-highlighter shared/shell/string.symbol region ':"' '(?<!\\)(\\\\)*"' ref shell/string

# Regular expressions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/regex.html

# Regex literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# /foo/i.match("FOO")
#
add-highlighter shared/shell/string.regexp.interpolated region '/' '(?<!\\)(\\\\)*/[imx]*' regions
add-highlighter shared/shell/string.regexp.interpolated/content default-region group
add-highlighter shared/shell/string.regexp.interpolated/content/fill fill meta
add-highlighter shared/shell/string.regexp.interpolated/content/escaped-character ref shell/string/content/escaped-character
add-highlighter shared/shell/string.regexp.interpolated/content/escape-sequence ref shell/string/content/escape-sequence
add-highlighter shared/shell/string.regexp.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/shell/string.regexp.interpolated/interpolation/delimiters ref shell/string.interpolated/interpolation/delimiters
add-highlighter shared/shell/string.regexp.interpolated/interpolation/shell ref shell

# Note: Avoid unterminated regular expression and floor division as regex.
#
# Examples:
#
# division ⇒ 1 / 2
# floor division ⇒ 1 // 2
#
add-highlighter shared/shell/division-as-region region ' //? ' '.\K' group
add-highlighter shared/shell/division-as-region/operator regex '//?' 0:operator

# Percent regex literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %r(foo|bar)
#
add-highlighter shared/shell/string.regexp.percent.parenthesis.interpolated region -recurse '\(' '%r\(' '\)[imx]*' ref shell/string.regexp.interpolated
add-highlighter shared/shell/string.regexp.percent.bracket.interpolated region -recurse '\[' '%r\[' '\][imx]*' ref shell/string.regexp.interpolated
add-highlighter shared/shell/string.regexp.percent.brace.interpolated region -recurse '\{' '%r\{' '\}[imx]*' ref shell/string.regexp.interpolated
add-highlighter shared/shell/string.regexp.percent.angle.interpolated region -recurse '<' '%r<' '>[imx]*' ref shell/string.regexp.interpolated
add-highlighter shared/shell/string.regexp.percent.pipe.interpolated region '%r\|' '\|[imx]*' ref shell/string.regexp.interpolated

# Command literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://shell-lang.org/reference/master/syntax_and_semantics/literals/command.html

# Example:
#
# `echo foo`
#
add-highlighter shared/shell/string.command region '`' '(?<!\\)(\\\\)*`' ref shell/string.regexp.interpolated

# Percent command literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %x(echo foo)
#
add-highlighter shared/shell/string.command.percent.parenthesis region -recurse '\(' '%x\(' '\)' ref shell/string.regexp.interpolated
add-highlighter shared/shell/string.command.percent.bracket region -recurse '\[' '%x\[' '\]' ref shell/string.regexp.interpolated
add-highlighter shared/shell/string.command.percent.brace region -recurse '\{' '%x\{' '\}' ref shell/string.regexp.interpolated
add-highlighter shared/shell/string.command.percent.angle region -recurse '<' '%x<' '>' ref shell/string.regexp.interpolated
add-highlighter shared/shell/string.command.percent.pipe region '%x\|' '\|' ref shell/string.regexp.interpolated

# What’s new ───────────────────────────────────────────────────────────────────

# Builds a ready for use `str-list` and `regex` with selections.
#
# Usage:
#
# Fetch a document, select keywords and call `shell-build-result keywords`.
#
define-command -hidden shell-build-result -params 1 %{
  # Initialization
  execute-keys -save-regs '' 'y'
  edit -scratch

  execute-keys '%<a-R>a<ret><esc>y%<a-R>%|sort -u<ret><a-s>_'
  echo -debug shell %arg{1} as str-list:
  echo -debug -quoting shell %val{selections}

  execute-keys '%|awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>_'
  execute-keys -save-regs '' '*'
  echo -debug shell %arg{1} as regex:
  echo -debug -quoting shell %val{main_reg_slash}

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}

define-command -hidden shell-build-result-with-static-words -params 1 %{
  shell-build-result %arg{1}
  set-option -add window static_words %val{selections}
}

define-command -hidden shell-check-news %{
  # Initialization
  edit -scratch
  set-option window static_words

  # Keywords ⇒ https://github.com/shell-lang/shell/blob/master/src/compiler/shell/syntax/lexer.cr
  execute-keys '%|curl -sSL https://github.com/shell-lang/shell/raw/master/src/compiler/shell/syntax/lexer.cr<ret>'
  execute-keys '%1<s>check_ident_or_keyword\(:(%opt{shell_word_pattern}<a-!>),\h+\w+\)<ret>Z%1<s>@token\.value\h+=\h+:(%opt{shell_word_pattern}<a-!>)<ret><a-z>a'
  shell-build-result-with-static-words keywords

  # Top Level Namespace
  # https://shell-lang.org/api/master/toplevel.html#method-summary
  # https://shell-lang.org/api/master/toplevel.html#macro-summary
  execute-keys '%|curl -sSL https://shell-lang.org/api/master/toplevel.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{shell_word_pattern}<a-!>)[^"]*-(method|macro)"<ret>'
  shell-build-result-with-static-words top-level-namespace

  # Object macros ⇒ https://shell-lang.org/api/master/Object.html#macro-summary
  execute-keys '%|curl -sSL https://shell-lang.org/api/master/Object.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{shell_word_pattern}<a-!>)[^"]*-(macro)"<ret>'
  shell-build-result-with-static-words object-macros

  # Static words
  set-register dquote %opt{static_words}
  execute-keys '%<a-R>'
  shell-build-result static_words

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}
