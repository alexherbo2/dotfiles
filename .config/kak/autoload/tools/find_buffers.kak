define-command find_buffers -params 1 %{
  edit! -scratch '*find*'
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

complete-command find_buffers buffer
