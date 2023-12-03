define-command find_buffers -params 1 %{
  evaluate-commands -save-regs '"' %{
    try %{
      execute-keys -buffer '*find*' -save-regs '' '%y'
    } catch %{
      set-register dquote
    }
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
    execute-keys -buffer '*find*' 'P'
  }
}

complete-command find_buffers buffer
