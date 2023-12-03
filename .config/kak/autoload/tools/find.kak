declare-option str find_command find
declare-option str-list find_args -type f

declare-option str find_completion %{
  eval "$kak_quoted_opt_find_command" "$kak_quoted_opt_find_args"
}

define-command find -params .. %{
  evaluate-commands -save-regs '"' %{
    try %{
      execute-keys -buffer '*find*' -save-regs '' '%y'
    } catch %{
      set-register dquote
    }
    create_buffer_from_command_output '*find*' %opt{find_command} %opt{find_args} %arg{@}
    execute-keys -buffer '*find*' 'P'
  }
}

complete-command find file

add-highlighter shared/find regex '^(.+?)$' 0:value

hook global BufCreate '\*find\*' %{
  set-option buffer filetype find
}

hook global BufSetOption filetype=find %{
  add-highlighter buffer/find ref find
  map -docstring 'jump to files' buffer normal <ret> ':jump_to_files<ret>'
  map -docstring 'jump to files and close find buffer' buffer normal <s-ret> ':jump_to_files_and_close_find_buffer<ret>'
}

define-command -hidden jump_to_files %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>H'
    evaluate-commands -itersel %{
      evaluate-commands -client %val{client} -verbatim edit -existing -- %val{selection}
    }
  }
}

define-command -hidden jump_to_files_and_close_find_buffer %{
  jump_to_files
  delete-buffer '*find*'
}

define-command -hidden open_find_buffer_and_jump_to_files -params 1 %{
  buffer '*find*'
  execute-keys ",;%arg{1}gh"
  jump_to_files
}

define-command jump_to_next_file %{
  open_find_buffer_and_jump_to_files 'j'
}

define-command jump_to_previous_file %{
  open_find_buffer_and_jump_to_files 'k'
}

define-command jump_to_first_file %{
  open_find_buffer_and_jump_to_files 'gk'
}

define-command jump_to_last_file %{
  open_find_buffer_and_jump_to_files 'gj'
}
