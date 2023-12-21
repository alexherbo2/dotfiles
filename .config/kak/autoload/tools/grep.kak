# name: kakoune_grep
# version: 0.1.0
# description: This script provides support for the grep command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["create_buffer_from_command_output"]
# doc: yes
# tests: no
declare-option str grep_command grep
declare-option str-list grep_args -R -H -n

declare-option str grep_word_completion %{
  kak_response_fifo=$(mktemp -u)
  mkfifo "$kak_response_fifo"
  echo "evaluate-commands -client $kak_client -verbatim write $kak_response_fifo" | kak -p "$kak_session"
  grep -o -w '[[:alpha:]][[:alnum:]_-]\+' < "$kak_response_fifo" | sort -u
  unlink "$kak_response_fifo"
}

define-command grep -params .. %{
  evaluate-commands -save-regs '"' %{
    try %{
      execute-keys -buffer '*grep*' -save-regs '' '%y'
    } catch %{
      set-register dquote
    }
    create_buffer_from_command_output '*grep*' %opt{grep_command} %opt{grep_args} %arg{@}
    execute-keys -buffer '*grep*' 'P'
  }
}

complete-command grep file

add-highlighter shared/grep regex '^(.+?)(:)(\d+)(:)(\d+)(:)(.+?)$' 1:string 2:operator 3:value 4:operator 5:value 6:operator

hook global BufCreate '\*grep\*' %{
  set-option buffer filetype grep
}

hook global BufSetOption filetype=grep %{
  add-highlighter buffer/grep ref grep
  map -docstring 'jump to references' buffer normal <ret> ':jump_to_references<ret>'
  map -docstring 'jump to references and close grep buffer' buffer normal <s-ret> ':jump_to_references_and_close_grep_buffer<ret>'
}

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
