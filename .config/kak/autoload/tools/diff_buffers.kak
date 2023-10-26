define-command diff_buffers -params 2 %{
  set-register t %sh{mktemp -d}
  set-register a "%reg{t}/a"
  set-register b "%reg{t}/b"
  evaluate-commands -buffer %arg{1} write %reg{a}
  evaluate-commands -buffer %arg{2} write %reg{b}
  create_buffer_from_command_output "%arg{1}_%arg{2}.diff" diff -u -- %reg{a} %reg{b}
  hook -always -once buffer BufCloseFifo '' "
    nop %%sh{
      rm -Rf -- ""%reg{t}""
    }
  "
}

complete-command diff_buffers buffer
alias global diff diff_buffers
