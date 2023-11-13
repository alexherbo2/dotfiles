define-command cp_buffers -params 2 %{
  evaluate-commands -save-regs 'abcd' %{
    buffer -- %arg{1}
    execute-keys -draft '%"ay'
    set-register b %val{selections_desc}
    set-register c %val{window_range}
    set-register d %opt{filetype}
    buffer -- %arg{2}
    evaluate_commands_with_values %{
      execute-keys "%%""aRgg%arg{2}jvt%arg{3}vl"
    } %reg{c}
    set-option buffer filetype %reg{d}
    select %reg{b}
  }
}

complete-command cp_buffers buffer
