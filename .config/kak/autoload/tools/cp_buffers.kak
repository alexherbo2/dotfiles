define-command cp_buffers -params 2 %{
  evaluate-commands -save-regs 'abcd' %{
    buffer -- %arg{1}
    execute-keys -draft '%"ay'
    set-register b %val{selections_desc}
    set-register c %val{window_range}
    set-register d %opt{filetype}
    buffer -- %arg{2}
    execute-keys "%%""aRge%reg{c}gjvt"
    set-option buffer filetype %reg{d}
    select %reg{b}
  }
}

complete-command cp_buffers buffer
