declare-option str grep_command grep
declare-option str-list grep_args -R -H -n
declare-option str grep_word_completion %{
  echo "write $kak_quoted_response_fifo" > "$kak_command_fifo"
  tr -sc '[:alnum:]_-' '\n' < "$kak_response_fifo"
}

define-command grep -params .. %{
  evaluate-commands -try-client %opt{tools_client} -verbatim create_buffer_from_command_output '*grep*' %opt{grep_command} %opt{grep_args} %arg{@}
}

complete-command grep file

add-highlighter shared/grep regex '^(.+?)(:)(\d+)(:)(\d+)(:)(.+?)$' 1:string 2:operator 3:value 4:operator 5:value 6:operator

hook global BufCreate '\*grep\*' %{
  set-option buffer filetype grep
}

hook global BufSetOption filetype=grep %{
  add-highlighter buffer/grep ref grep
  map -docstring 'jump to references' buffer goto f '<a-;>:jump_to_references<ret>'
  map -docstring 'jump to references and close grep buffer' buffer goto F '<a-;>:jump_to_references_and_close_grep_buffer<ret>'
}

define-command -hidden jump_to_references %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>H'
    evaluate-commands -itersel %{
      execute-keys 's^(.+?):(\d+):(\d+):(.+?)$<ret>'
      evaluate-commands -try-client %opt{jump_client} -verbatim edit -existing -- %reg{1} %reg{2} %reg{3}
    }
  }
}

define-command -hidden jump_to_references_and_close_grep_buffer %{
  jump_to_references
  delete-buffer '*grep*'
}

define-command -hidden open_grep_buffer_and_jump_to_references -params 1 %{
  evaluate-commands -try-client %opt{tools_client} %{
    buffer '*grep*'
    execute-keys ",gh%arg{1}"
    jump_to_references
  }
}

define-command jump_to_next_reference %{
  open_grep_buffer_and_jump_to_references 'j'
}

define-command jump_to_previous_reference %{
  open_grep_buffer_and_jump_to_references 'k'
}
