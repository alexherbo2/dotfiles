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