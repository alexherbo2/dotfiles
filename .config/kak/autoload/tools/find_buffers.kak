define-command find_buffers -params 1 %{
  edit! -scratch -- "%arg{1}.flist"
  evaluate-commands -save-regs '"/' %{
    set-register dquote %val{buflist}
    execute-keys '<a-R>a<ret><esc>'
    try %{
      set-register / %arg{1}
      execute-keys '<a-k><ret>y%<a-R>gg'
    } catch %{
      execute-keys '%d'
    }
  }
}

define-command open_buffer_finder %{
  prompt find_buffer: -buffer-completion %{
    find_buffers %val{text}
  }
}

define-command -hidden open_command_mode_for_each_selected_buffer %{
  prompt iterbuf: -command-completion %{
    iterbuf_impl %val{text}
  }
}

define-command -hidden iterbuf_impl -params 1 %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s>H<a-K>\A\h+.\z<ret>'
    evaluate-commands -itersel %{
      evaluate-commands -buffer %val{selection} -- %arg{1}
    }
  }
}

complete-command find_buffers buffer

hook global BufSetOption filetype=find %{
  map -docstring 'open command mode for each selected buffer' buffer user : ':open_command_mode_for_each_selected_buffer<ret>'
}
