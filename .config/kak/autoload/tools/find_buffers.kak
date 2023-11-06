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

complete-command find_buffers buffer
