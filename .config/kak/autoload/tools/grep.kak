declare-option str grep_command grep
declare-option str-list grep_args -R -H -n
declare-option str grep_word_completion %{
  echo "write $kak_quoted_response_fifo" > "$kak_command_fifo"
  tr -sc '[:alnum:]_-' '\n' < "$kak_response_fifo"
}

define-command grep -params .. %{
  set-register / %arg{1}
  create_buffer_from_command_output "%arg{1}.refs" %opt{grep_command} %opt{grep_args} -- %arg{@}
}

define-command open_global_search_prompt %{
  prompt global_search: -shell-script-candidates %opt{grep_word_completion} %{
    grep %val{text}
  }
}

define-command open_buffer_search_prompt %{
  prompt buffer_search: -shell-script-candidates %opt{grep_word_completion} %{
    grep %val{text} %val{buflist}
  }
}

complete-command grep file

add-highlighter shared/grep regex '^(.+?)(:)(\d+)(:)(\d+)(:)(.+?)$' 1:string 2:operator 3:value 4:operator 5:value 6:operator

hook global BufOpenFifo '.+\.refs' %{
  set-option buffer filetype grep
}

hook global BufSetOption filetype=grep %{
  add-highlighter buffer/grep ref grep
  map buffer normal <ret> ':jump_to_references<ret>'
}

define-command -hidden jump_to_references %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s>H'
    evaluate-commands -itersel %{
      execute-keys 's^(.+?):(\d+):(\d+):(.+?)$<ret>'
      evaluate-commands -client %val{client} -- edit -existing -- %reg{1} %reg{2} %reg{3}
    }
  }
}
