# name: kakoune_grep
# version: 0.1.0
# description: This script provides support for the grep command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
declare-option str grep_command grep
declare-option str-list grep_args -R -H -n

define-command grep -params .. %{
  evaluate-commands -save-regs '"' %{
    try %{
      execute-keys -buffer '*grep*' -save-regs '' '%y'
    } catch %{
      set-register dquote
    }
    fifo -name '*grep*' -- %opt{grep_command} %opt{grep_args} %arg{@}
    execute-keys -buffer '*grep*' 'P'
  }
}

complete-command grep file

define-command -hidden jump_to_references %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>Hs^(.+?):(\d+):(\d+):(.+?)$<ret>'
    evaluate-commands -itersel %{
      evaluate-commands -client %val{client} -verbatim edit -existing -- %reg{1} %reg{2} %reg{3}
    }
  }
}

define-command -hidden jump_to_references_and_close_grep_buffer %{
  jump_to_references
  delete-buffer '*grep*'
}

define-command -hidden open_grep_buffer_and_jump_to_references -params 1 %{
  buffer '*grep*'
  execute-keys ",;%arg{1}gh"
  jump_to_references
}

define-command jump_to_next_reference %{
  open_grep_buffer_and_jump_to_references 'j'
}

define-command jump_to_previous_reference %{
  open_grep_buffer_and_jump_to_references 'k'
}

alias global gn jump_to_next_reference
alias global gp jump_to_previous_reference
