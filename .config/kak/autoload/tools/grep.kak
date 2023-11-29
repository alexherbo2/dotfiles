declare-option str grep_command grep
declare-option str-list grep_args -R -H -n
declare-option str grep_word_completion %{
  echo "write $kak_quoted_response_fifo" > "$kak_command_fifo"
  tr -sc '[:alnum:]_-' '\n' < "$kak_response_fifo"
}

define-command grep -params .. %{
  set-register / %arg{1}
  evaluate-commands -try-client %opt{tools_client} -verbatim create_buffer_from_command_output "%arg{1}.refs" %opt{grep_command} %opt{grep_args} %arg{@}
}

complete-command grep file

add-highlighter shared/grep regex '^(.+?)(:)(\d+)(:)(\d+)(:)(.+?)$' 1:string 2:operator 3:value 4:operator 5:value 6:operator

hook global BufCreate '.+\.refs' %{
  set-option buffer filetype grep
}

hook global BufSetOption filetype=grep %{
  add-highlighter buffer/grep ref grep
  map -docstring 'jump to references' buffer goto f '<a-;>:jump_to_references<ret>'
}

define-command -hidden jump_to_references %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s>H<a-K>\A\h+.\z<ret>'
    evaluate-commands -itersel %{
      execute-keys 's^(.+?):(\d+):(\d+):(.+?)$<ret>'
      evaluate-commands -try-client %opt{jump_client} -verbatim edit -existing -- %reg{1} %reg{2} %reg{3}
    }
  }
}
