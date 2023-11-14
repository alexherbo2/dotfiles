define-command cp_buffers -params 2 %{
  evaluate-commands -save-regs '"stw' %{

    buffer -- %arg{1}
    evaluate-commands -draft %{
      set-register s %val{selections_desc}
      execute-keys 'gt'
      set-register w %val{cursor_line}
      execute-keys -save-regs '' '%y'
      set-register t %opt{filetype}
    }

    buffer -- %arg{2}
    set-option buffer filetype %reg{t}
    execute-keys "%%R%reg{w}gvt"
    select %reg{s}
  }
}

complete-command cp_buffers buffer
