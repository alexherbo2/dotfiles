define-command list_buffers %{
  evaluate-commands -try-client %opt{tools_client} %{
    edit! -scratch -- '*buffers*'
    edit! -scratch -debug -- '*buffers_tmp*'
    evaluate-commands -no-hooks -buffer '*' -verbatim -- try %{
      set-register dquote "%val{bufname} (filetype=%opt{filetype}, readonly=%opt{readonly}, modified=%val{modified})"
      execute-keys -buffer '*buffers_tmp*' 'gep'
    }
    execute-keys 'd%y:delete-buffer<ret>Rgg'
  }
}

add-highlighter shared/buffer_list regex '^(.+?) (\()(.+?)(\))$' 1:string 2:operator 3:value 4:operator

hook global BufCreate '\*buffers\*' %{
  set-option buffer filetype buffer_list
}

hook global BufSetOption filetype=buffer_list %{
  add-highlighter buffer/buffer_list ref buffer_list
  map -docstring 'jump to buffers' buffer goto f '<a-;>:jump_to_buffers<ret>'
  map -docstring 'jump to buffers and close buffer_list buffer' buffer goto F '<a-;>:jump_to_buffers_and_close_buffer_list_buffer<ret>'
}

define-command -hidden jump_to_buffers %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>H'
    evaluate-commands -itersel %{
      execute-keys 's^(.+?) \(.+?\)$<ret>'
      evaluate-commands -client %val{client} -verbatim evaluate-commands -try-client %opt{jump_client} -verbatim buffer -- %reg{1}
    }
  }
}

define-command -hidden jump_to_buffers_and_close_buffer_list_buffer %{
  jump_to_buffers
  delete-buffer '*buffers*'
}

define-command -hidden open_buffer_list_buffer_and_jump_to_buffers -params 1 %{
  evaluate-commands -try-client %opt{tools_client} %{
    buffer '*buffers*'
    execute-keys ",;%arg{1}gh"
    jump_to_buffers
  }
}

define-command jump_to_next_buffer %{
  open_buffer_list_buffer_and_jump_to_buffers 'j'
}

define-command jump_to_previous_buffer %{
  open_buffer_list_buffer_and_jump_to_buffers 'k'
}

define-command jump_to_first_buffer %{
  open_buffer_list_buffer_and_jump_to_buffers 'gk'
}

define-command jump_to_last_buffer %{
  open_buffer_list_buffer_and_jump_to_buffers 'gj'
}
