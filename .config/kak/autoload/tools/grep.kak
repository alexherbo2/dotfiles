declare-option str grep_command rg
declare-option str-list grep_args --vimgrep --hidden
declare-option str grep_word_completion %{
  echo "write $kak_quoted_response_fifo" > "$kak_command_fifo"
  tr -sc '[:alnum:]' '\n' < "$kak_response_fifo"
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
